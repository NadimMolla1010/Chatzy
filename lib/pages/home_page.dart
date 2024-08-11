import 'package:chatzy/components/user_tile.dart';
import 'package:chatzy/pages/chat_page.dart';
import 'package:chatzy/services/auth/auth_service.dart';
import 'package:chatzy/components/my_drawer.dart';
import 'package:chatzy/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        // Uncomment the actions section if needed
        // actions: [
        //   // Logout button
        //   IconButton(onPressed: logout, icon: Icon(Icons.logout))
        // ],
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of users except for the currently logged-in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // Handle error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // Return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData) {
            // Check if the email is null
            if (userData["email"] == null) {
              return const Text("Invalid user data");
            }
            return _buildUserListItem(userData, context);
          }).toList(),
        );
      },
    );
  }

  // Build individual list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  //display all except current user

    if(userData["email"]!= _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"], // Ensure email is not null
        onTap: () {
          // Tapped a user => go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"], // Ensure email is not null
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    }
    else {
      return Container();
    }

  }
}
