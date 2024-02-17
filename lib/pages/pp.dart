import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tes/componrts/tedxt.dart';

class pp extends StatefulWidget {
  const pp({super.key, required this.u});
  final String u;

  @override
  State<pp> createState() => _ppState();
}

class _ppState extends State<pp> {
  final uy = FirebaseFirestore.instance.collection('users');
  final curr = FirebaseAuth.instance.currentUser!;
  String val = "";

  Future<void> edit(String field) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit$field",
        ),
        content: TextField(
            autofocus: true,
            style: const TextStyle(color: Color.fromARGB(255, 15, 15, 15)),
            decoration: const InputDecoration(hintText: 'enter new name'),
            onChanged: (value) {
              val = value;
            }),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(val),
              child: const Text('save'))
        ],
      ),
    );
    if (val.trim().length > 0) {
      await uy.doc(curr.email).update({field: val});
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 202, 202),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 173, 173),
        title:
         
           const Text("profile",textAlign: TextAlign.center,),
        
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(curr.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dte = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.person,
                    size: 70,
                  ),
                  Text(
                    curr.email!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color.fromARGB(255, 54, 52, 52)),
                  ),
                  teste(
                    sectionName: 'user bio',
                    text: dte['username'],
                    onpr: () => edit('username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  teste(
                    sectionName: 'bio',
                    text: dte['bio'],
                    onpr: () => edit('bio'),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('error${snapshot.error}'));
            }

            return const CircularProgressIndicator();
          }),
    );
  }
}
