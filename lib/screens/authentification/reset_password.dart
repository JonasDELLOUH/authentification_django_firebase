import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utility/textButton.dart';
import '../../core/utility/text_widgets.dart';
import '../../core/utility/textfield.dart';

class ResetPassword extends StatefulWidget {
  static String routeName = '/reset-password';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController password1_controller = TextEditingController();
  TextEditingController password2_controller = TextEditingController();
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(30),
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
              child: boldText(text: 'Reset Password?'),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Text("Don't worry! It happen. Please enter the adsress associated with your account"),
            SizedBox(
              height: height * 0.04,
            ),
            textField(
                controller: password1_controller,
                keyboardType: TextInputType.text,
                icon: Icons.lock,
                hintText: "New Password"),
            SizedBox(
              height: height * 0.03,
            ),
            textField(
                controller: password1_controller,
                keyboardType: TextInputType.text,
                icon: Icons.mail,
                hintText: "Confirm new password"),
            SizedBox(
              height: height * 0.04,
            ),
            textButton(
                text: "Submit",
                function: () {},
                height: height * 0.06,
                width: width * 0.8),
          ],
        ),
      ),
    );
  }
}
