import 'package:flutter/material.dart';

class rext extends StatelessWidget {
  const rext(
      {super.key, required this.con, required this.hintext, required this.obs});
  final con;
  final String hintext;
  final obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
          controller: con,
          obscureText: obs,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            fillColor: const Color.fromARGB(255, 240, 190, 190),
            filled: true,
            hintText: hintext,
          )),
    );
  }
}
