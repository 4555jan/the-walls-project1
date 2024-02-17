import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class like extends StatelessWidget {
  void Function()? ontap;
  final  bool lik;
   like({super.key,required this.lik, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Icon(lik ?Icons.favorite: Icons.favorite_border,
      color: lik? Colors.red : Colors.grey
      )
    );
  }
}