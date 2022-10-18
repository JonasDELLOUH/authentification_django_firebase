import 'package:flutter/material.dart';

Widget boldText({required String text, Color color = Colors.black}) {
  return Text(
    text,
    style:  TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: color),
  );
}

Widget smallText({required String text, Color color = Colors.black}) {
  return Text(
    text,
    style:  TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: color),
  );
}
