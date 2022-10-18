import 'package:authentification_django_firebase/core/utility/textButton.dart';
import 'package:authentification_django_firebase/screens/authentification/forget_password.dart';
import 'package:authentification_django_firebase/screens/authentification/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/services/firebase/firebase_auth_methods.dart';
import '../../core/utility/text_widgets.dart';
import '../../core/utility/textfield.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = true;

  double height = 0;
  double width = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
      email: mailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
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
                child: boldText(text: 'Login'),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              textField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.mail,
                  hintText: "E-mail ID"),
              SizedBox(
                height: height * 0.03,
              ),
              textFieldP(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  icon: Icons.lock,
                  hintText: "Password"),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgetPassword()));
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              textButton(
                  text: "Login",
                  function: loginUser,
                  height: height * 0.06,
                  width: width * 0.8),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: height * 0.06,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15), right: Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: height * 0.03,
                      ),
                      const Text(
                        "Login with Google",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "New to Logistic?  ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  TextSpan(
                      text: "Register ",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));
                      }
                  ),
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
