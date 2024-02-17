import 'package:flutter/material.dart';

// ignore: camel_case_types
class com extends StatelessWidget {
  const com(
      {super.key, required this.co, required this.text, required this.time});
  final String text;
  final String co;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 199, 199),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(15),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 12),
          Text(text.split("@")[0]),
          Row(
            children: [Text(co), const Text("."), Text(time)],
          )
        ],
      ),
    );
  }
}
