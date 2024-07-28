import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback ontap;
  const CustomButton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      child: Text(
        'Book',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
          maximumSize: Size(100, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,foregroundColor: Colors.white),
    );
  }
}
