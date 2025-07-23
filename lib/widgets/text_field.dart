import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  customtextfield({super.key, this.hinttext, this.onChanged});
  final String? hinttext;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        obscureText: hinttext == 'Password' ? true : false,
        validator: (data) {
          if (data!.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
