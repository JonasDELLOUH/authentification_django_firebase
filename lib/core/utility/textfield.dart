import 'package:flutter/material.dart';

Widget textField(
    {required TextEditingController controller,
    bool isobscureText = false,
    TextInputType keyboardType = TextInputType.text,
    IconData icon = Icons.add,
    bool hasIcon = true}) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: isobscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: hasIcon ? Icon(icon, color: Colors.black,) : null,
        ),
        cursorColor: Colors.grey,
      ));
}
