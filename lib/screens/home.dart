import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/firebase/firebase_auth_methods.dart';
import '../core/utility/textButton.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          textButton(
              text: "Logout",
              function: (){
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              height: height * 0.06,
              width: width * 0.8),
        ],
      ),
    );
  }
}
