import 'package:flutter/material.dart';
class ctm extends StatelessWidget {
  const ctm({super.key, required this.ontap});
final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
     child: Icon(Icons.comment,color: Colors.grey,)
     
     
      
    );
  }
}