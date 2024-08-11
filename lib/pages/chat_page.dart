import 'package:chatzy/components/chat_bubble.dart';
import 'package:chatzy/components/my_textfield.dart';
import 'package:chatzy/services/auth/auth_service.dart';
import 'package:chatzy/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // Import dart:io to use File

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // file picker result
  FilePickerResult? _selectedFile;

  // send messages
  void sendMessage() async {
    if (_messageController.text.isNotEmpty || _selectedFile != null) {
      if (_selectedFile != null) {
        // Handle file sending
        String fileUrl = await _uploadFile(_selectedFile!);
        await _chatService.sendMessage(widget.receiverID, fileUrl, isFile: true); // Add isFile parameter here
        _selectedFile = null; // Clear selected file after sending
      } else {
        await _chatService.sendMessage(widget.receiverID, _messageController.text);
      }

      // clear text controller
      _messageController.clear();
      setState(() {});
    }
  }

  // upload file
  Future<String> _uploadFile(FilePickerResult result) async {
    String userId = FirebaseAuth.instance.currentUser!.uid; // Get the current user's ID
    String fileName = result.files.single.name;
    File file = File(result.files.single.path!);
    try {
      Reference ref = FirebaseStorage.instance.ref().child('$userId/uploads/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
      body: Column(
        children: [
          // display messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading . . . .");
        }

        // Return ListView
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to right if sender is current user, otherwise left
    Alignment alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'],
            isCurrentUser: isCurrentUser,
            isFile: data['isFile'] ?? false, // Provide a default value for isFile
          ),
        ],
      ),
    );
  }

  // create user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          if (_selectedFile != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(Icons.attach_file),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedFile!.names.first!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _selectedFile = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          Row(
            children: [
              // file upload button
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: IconButton(
                  onPressed: uploadFile,
                  icon: const Icon(Icons.attach_file),
                ),
              ),
              // textfield should take most of the space
              Expanded(
                child: MyTextfield(
                  controller: _messageController,
                  hintText: "Type a message",
                  obsecureText: false,
                ),
              ),
              // send button
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(right: 25),
                child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
