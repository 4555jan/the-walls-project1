import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:tes/pages/hp.dart';
import 'package:tes/utils%20and%20otherfiles/lorr.dart';
import 'package:tes/pages/t.dart';

class aut extends StatelessWidget {
  const aut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return hp();
          
        }
        else{
          return lorr();
        }
      },
       ) ,
    );;
  }
}