import 'package:authentification_django_firebase/core/utility/text_widgets.dart';
import 'package:authentification_django_firebase/core/utility/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController mail_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController tel_controller = TextEditingController();
  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: Center(child: SvgPicture.asset('assets/illustrations/account_icons.svg', height: height*0.20, width: width*0.75,))
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.centerLeft,
                child: boldText('Sign up'),
              ),
              SizedBox(height: 20,),
              textField(controller: mail_controller, keyboardType: TextInputType.emailAddress, icon: Icons.mail),
              const SizedBox(height: 20,),
              textField(controller: name_controller, icon: Icons.person),
              const SizedBox(height: 20,),
              textField(controller: tel_controller, keyboardType: TextInputType.number, icon: Icons.phone),
              const SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
