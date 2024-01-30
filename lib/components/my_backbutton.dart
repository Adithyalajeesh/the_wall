import 'package:flutter/material.dart';

class MybackButton extends StatelessWidget {
  const MybackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        child: Icon(Icons.arrow_back),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
