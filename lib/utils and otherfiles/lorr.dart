import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tes/pages/res.dart';
import 'package:tes/pages/t.dart';

class lorr extends StatefulWidget {
  const lorr({super.key});

  @override
  State<lorr> createState() => _lorrState();
}

class _lorrState extends State<lorr> {
  bool sp=true;
  void rt(){
    setState(() {
      sp=!sp;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (sp) {
      return t(ongr: rt,);
    }
    else{
      return res(onyop: rt,);
    }
  }
  
}