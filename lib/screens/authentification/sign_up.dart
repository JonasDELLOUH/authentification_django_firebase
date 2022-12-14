import 'package:authentification_django_firebase/core/utility/textButton.dart';
import 'package:authentification_django_firebase/core/utility/text_widgets.dart';
import 'package:authentification_django_firebase/core/utility/textfield.dart';
import 'package:authentification_django_firebase/screens/authentification/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/services/firebase/firebase_auth_methods.dart';

class SignUp extends StatefulWidget {
  static String routeName = '/sign-up';

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController mail_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController tel_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  bool passwordVisible = true;

  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();
  }

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: mail_controller.text,
          password: password_controller.text,
          context: context,
          fullName: name_controller.text,
          phone: tel_controller.text,
        );
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
              Container(
                  child: Center(
                      child: SvgPicture.asset(
                'assets/illustrations/account_icons.svg',
                height: height * 0.20,
                width: width * 0.75,
                color: Colors.blue,
              ))),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: boldText(text: 'Sign up'),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              textField(
                  controller: mail_controller,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.mail,
                  hintText: "E-mail ID"),
              SizedBox(
                height: height * 0.03,
              ),
              textField(
                  controller: name_controller,
                  icon: Icons.person,
                  hintText: "Full name"),
              const SizedBox(
                height: 20,
              ),
              textField(
                  controller: tel_controller,
                  keyboardType: TextInputType.number,
                  icon: Icons.phone,
                  hintText: "Mobile"),
              SizedBox(
                height: height * 0.03,
              ),
              textFieldP(
                  controller: password_controller,
                  keyboardType: TextInputType.text,
                  icon: Icons.lock,
                  hintText: "Password"),
              SizedBox(
                height: height * 0.03,
              ),
              RichText(
                  text: TextSpan(
                children: [
                  const TextSpan(
                      text: "By signing up, you're agree to our ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  TextSpan(
                      text: "Terms & Conditions ",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue),
                      onEnter: (event) {}),
                  const TextSpan(
                      text: "and ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue),
                      onEnter: (event) {}),
                ],
              )),
              SizedBox(
                height: height * 0.04,
              ),
              textButton(
                  text: "Continue",
                  function: signUpUser,
                  height: height * 0.06,
                  width: width * 0.8),
              SizedBox(
                height: height * 0.04,
              ),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Joined us before?  ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  TextSpan(
                      text: "Login ",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldP(
      {required TextEditingController controller,
      TextInputType keyboardType = TextInputType.text,
      IconData icon = Icons.add,
      bool hasIcon = true,
      String hintText = ""}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: passwordVisible,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: hasIcon
              ? Icon(
                  icon,
                  color: Colors.black,
                )
              : null,
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible == false
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
        ),
        cursorColor: Colors.grey,
      ),
    );
  }
}
