import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container( // Changes: Added Container here
        decoration: BoxDecoration( // Moved decoration inside Container
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(25), // Moved padding inside Container
        margin: const EdgeInsets.symmetric(horizontal: 25), // Moved margin inside Container
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary), // Added text style
          ),
        ),
      ),
    );
  }
}
