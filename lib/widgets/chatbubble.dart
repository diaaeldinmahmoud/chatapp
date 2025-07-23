import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/models/message_model.dart';

class chatbubble extends StatelessWidget {
  chatbubble({super.key, required this.message});
  MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: kPrimarycolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class chatbubblefriend extends StatelessWidget {
  chatbubblefriend({super.key, required this.message});
  MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
