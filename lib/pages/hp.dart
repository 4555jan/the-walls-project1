import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tes/componrts/fg.dart';
import 'package:tes/componrts/post.dart';
import 'package:tes/pages/pp.dart';
import 'package:tes/componrts/text.dart';

class hp extends StatelessWidget {
  hp({super.key});
  void out() {
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser!;
  final op = FirebaseFirestore.instance.collection('users');

  final u = TextEditingController();
  void iu() {
    if (!u.text.isEmpty) {
      FirebaseFirestore.instance.collection('post').add({
        'UserEmail': user.email,
        'Message': u.text,
        'time': Timestamp.now(),
        'likes': []
      });
      // Clear the text field after adding a post
      u.clear();
    }
  }

  final String o = 'walls';
  @override
  Widget build(BuildContext context) {
    void ppage() {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => pp(
                    u: u.value.text,
                  )));
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 215, 215),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 180, 180),
        title: const Center(child: Text('walls')),
        actions: [IconButton(onPressed: out, icon: const Icon(Icons.logout))],
      ),
      drawer: draw(
        io: ppage,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('post')
                        .orderBy('time', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final post = snapshot.data!.docs[index];
                            return pos(
                              msg: post['Message'],
                              user: post['UserEmail'].split('@')[0],
                              postid: post.id,
                              likes: List<String>.from(post['likes'] ?? []),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('error: ${snapshot.error}'));
                      }
                      return const Center(child: CircularProgressIndicator());
                    })),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                      child: rext(con: u, hintext: 'write it ', obs: false)),
                  IconButton(
                      onPressed: iu, icon: const Icon(Icons.arrow_circle_up))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
