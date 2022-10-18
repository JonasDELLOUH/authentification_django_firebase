import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/services/firebase/firebase_auth_methods.dart';
import '../../core/utility/textButton.dart';
import '../../core/utility/text_widgets.dart';
import '../../core/utility/textfield.dart';

class ForgetPassword extends StatefulWidget {
  static String routeName = '/forget-password';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController mailOrTelController = TextEditingController();
  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Center(
                  child: SvgPicture.asset(
                'assets/illustrations/account_icons.svg',
                height: height * 0.20,
                width: width * 0.75,
                color: Colors.blue,
              )),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: boldText(text: 'Forget Password?'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Text("Don't worry! It happen. Please enter the adsress associated with your account"),
              SizedBox(
                height: height * 0.04,
              ),
              textField(
                  controller: mailOrTelController,
                  keyboardType: TextInputType.text,
                  icon: Icons.mail,
                  hintText: "E-mail ID / Mobile Number"),
              SizedBox(
                height: height * 0.04,
              ),
              textButton(
                  text: "Submit",
                  function: () {
                    context.read<FirebaseAuthMethods>().resetPassword(email: mailOrTelController.text, context: context);
                  },
                  height: height * 0.06,
                  width: width * 0.8),
            ],
          ),
        ),
      ),
    );
  }
}
