import 'package:firebase_auth/firebase_auth.dart';
import 'package:tes/componrts/btn.dart';
import 'package:tes/componrts/text.dart';
import 'package:flutter/material.dart';

class t extends StatefulWidget {
  t({super.key, required this.ongr});
  final Function()? ongr;

  @override
  State<t> createState() => _tState();
}

class _tState extends State<t> {
  final use = TextEditingController();

  final pass = TextEditingController();
  void dis(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void sign() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator.adaptive());
        });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: use.text, password: pass.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(231, 243, 178, 178),
        title: const Center(child: Text("login")),
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
              Icons.favorite_border_outlined,
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
              obs: true,
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: widget.ongr,
              child: const Padding(
                padding: EdgeInsets.only(left: 120),
                child: Text(
                  'register now',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            btn(
              ontap: sign,
              tex: 'sign in',
            )
          ],
        ),
      ),
    );
  }
}
