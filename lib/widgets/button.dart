import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  custombutton({super.key, required this.text, this.ontap});
  String text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 60,
          width: double.infinity,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
