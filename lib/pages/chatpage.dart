import 'package:chatapp/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chatpage extends StatelessWidget {
  Chatpage({super.key});
  static String id = 'Chatpage';

  final _controller = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );

  TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(
              MessageModel.fromJson(snapshot.data!.docs[i].data()),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: kPrimarycolor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                    alignment: Alignment.center,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(
                      fontFamily: 'pacifico',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,

                    itemBuilder: (context, index) {
                      return messagelist[index].email == email
                          ? chatbubble(message: messagelist[index])
                          : chatbubblefriend(message: messagelist[index]);
                    },
                    itemCount: messagelist.length,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: Controller,
                    onSubmitted: (value) {
                      messages.add({
                        'message': value,
                        'time': DateTime.now(),
                        "email": email,
                      });
                      // Handle send action
                      Controller.clear();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_controller.hasClients) {
                          _controller.animateTo(
                            0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      });
                    },

                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimarycolor, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: kPrimarycolor),
                        onPressed: () {
                          // Handle send action
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
