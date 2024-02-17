import 'package:flutter/material.dart';

// ignore: must_be_immutable
class li extends StatelessWidget {
  li({super.key, required this.ICON, required this.text, required this.on});
  final ICON;
  final text;
  void Function()? on;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        ICON,
        color: Colors.white,
      ),
      onTap: on,
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
