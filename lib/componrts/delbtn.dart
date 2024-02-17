import 'package:flutter/material.dart';
class del extends StatelessWidget {
  const del({super.key,required this.ontap});
  final void Function()?ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ,
      child: const Icon(Icons.delete,color:Colors.black),
    );
  }
}