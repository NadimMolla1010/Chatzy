import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  //const MyTextfield({super.key});
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obsecureText,
    required this.controller,

  });
  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
      
     child: TextField(
       obscureText: obsecureText,
       controller: controller,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary
          ),
        ),
            focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
      ),
    ),
    fillColor: Theme.of(context).colorScheme.secondary,
       filled: true,
       hintText: hintText,

      ),

    ),
    );
  }
}
