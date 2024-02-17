import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tes/componrts/btn.dart';
import 'package:tes/componrts/text.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class res extends StatefulWidget {
  const res({super.key, required this.onyop});
  final Function()? onyop;
  @override
  State<res> createState() => _resState();
}

// ignore: camel_case_types
class _resState extends State<res> {
  final use = TextEditingController();
  final pass = TextEditingController();
  final cpass = TextEditingController();
  final yt = TextEditingController();

  void dis(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void signup() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    if (pass.text != cpass.text) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('pass is wrong'),
            );
          });
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: use.text, password: pass.text);

      FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
            'username': use.text.split('@')[0],
            'bio':'empty bio'
          });
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      dis(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(238, 239, 176, 176),
        title: const Center(child: Text("register")),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: Icon(
              Icons.favorite_outline_outlined,
              size: 180,
            )),
            const SizedBox(
              height: 25,
            ),
            Text(
              'welcome back',
              style: TextStyle(color: Colors.grey[700], fontSize: 17),
            ),
            rext(
              con: use,
              hintext: 'username',
              obs: false,
            ),
            const SizedBox(
              height: 16,
            ),
            rext(
              con: pass,
              hintext: 'password',
              obs: false,
            ),
            const SizedBox(
              height: 16,
            ),
            rext(
              con: cpass,
              hintext: 'confirm password',
              obs: false,
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: widget.onyop,
              child: const Padding(
                padding: EdgeInsets.only(left: 120),
                child: Text(
                  'login now',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            btn(
              ontap: signup,
              tex: 'sign up',
            )
          ],
        ),
      ),
    );
  }
}
