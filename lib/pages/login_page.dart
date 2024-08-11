import 'package:chatzy/services/auth/auth_service.dart';
import 'package:chatzy/components/my_button.dart';
import 'package:chatzy/components/my_textfield.dart';
import 'package:chatzy/services/auth/auth_service.dart';
import 'package:flutter/material.dart';// TODO Implement this library.

class LoginPage extends StatelessWidget {

  //const LoginPage({super.key});
  //email and password text controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //tap to go to register page

 final  void Function ()? onTap;

LoginPage({super.key , required this.onTap});


//login method
  void login( BuildContext context)  async {
//auth service

  final authService = AuthService();

  // try login

    try{
      await authService.signInWithEmailPassword(_emailController.text,
        _passwordController.text,
      );

    }

    //catch any errors
    catch (e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),);
    }

    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

        children: [
         //logo
          Icon(Icons.message,
          size: 60,
          color: Theme.of(context).colorScheme.primary,
               ),


        SizedBox(
          height: 50,
        ),
        //welcome message

          Text(" Welcome Back, conversation missed you ! ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
          ),

        SizedBox(height: 25,),

        //email text

          MyTextfield(
            hintText: " Email ",
            obsecureText: false,
            controller: _emailController,
          ),


          SizedBox(height: 16,),

      //password text
          MyTextfield(
            hintText: " Password ",
            obsecureText: true,
            controller: _passwordController,
          ),


          SizedBox(height: 25,),

        //login button
          MyButton(
            text: "Login ",
            onTap: () => login(context),

          ),


          SizedBox(height: 25,),

        //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member? "),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Register Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

            ],
          )

          
          
        ],
      )
      )
    );
  }
}

