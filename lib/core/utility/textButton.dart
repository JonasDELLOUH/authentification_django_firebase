import 'package:flutter/material.dart';

Widget textButton(
    {required String text,
    double height = 0.0,
    double width = 0.0,
    required Function() function}) {
  return InkWell(
    onTap: function,
    child: Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15), right: Radius.circular(15)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
