
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class btn extends StatelessWidget {
  const btn({super.key,required this.ontap,required this.tex});
  final Function()? ontap;
  final String tex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(25),
        decoration:  BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16)
        ),
        child:  Center(
          child: Text(
            tex,
            style: const TextStyle(color: Color.fromARGB(255, 254, 252, 252)),
          ),
        ),
      ),
    );
  }
}
