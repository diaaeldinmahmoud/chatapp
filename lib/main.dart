import 'package:flutter/material.dart';
import 'package:chatapp/pages/loginpage.dart';
import 'package:chatapp/pages/registerscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:chatapp/pages/chatpage.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const chatapp());
}

class chatapp extends StatelessWidget {
  const chatapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Loginpage': (context) => Loginpage(),
        register().id: (context) => register(),
        Chatpage.id: (context) => Chatpage(),
      },

      initialRoute: 'Loginpage',
      home: Loginpage(),
    );
  }
}
