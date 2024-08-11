import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final bool isFile; // Add isFile property

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.isFile = false, // Add isFile default value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green[200] : Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: isFile
          ? InkWell(
        onTap: () => _openFile(message), // Open the file when tapped
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.attach_file),
            Text(
              'File',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      )
          : Text(message),
    );
  }

  void _openFile(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
