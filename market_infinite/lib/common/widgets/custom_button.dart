import 'package:flutter/material.dart';
import 'package:market_infinite/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({super.key, required this.text, required this.onTap, this.color = GlobalVariables.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text,
      style: TextStyle(
        color: color ==GlobalVariables.secondaryColor ? Colors.white : Colors.black,
      ),),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}