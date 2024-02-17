import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tes/componrts/cmtbtn.dart';
import 'package:tes/componrts/comment.dart';
import 'package:tes/componrts/delbtn.dart';
import 'package:tes/utils%20and%20otherfiles/helper.dart';
import 'package:tes/componrts/likes.dart';

class pos extends StatefulWidget {
  final String msg;
  final String user;
  final String postid;
  final List<String> likes;

  const pos(
      {super.key,
      required this.msg,
      required this.user,
      required this.likes,
      required this.postid});

  @override
  State<pos> createState() => _posState();
}

// ignore: camel_case_types
class _posState extends State<pos> {
  final iu = FirebaseAuth.instance.currentUser!;

  final u = TextEditingController();
  bool lik = false;
  @override
  void initState() {
    lik = widget.likes.contains(iu.email!);
    super.initState();
  }

  void aad(String hi) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(widget.postid)
        .collection("comments")
        .add({
      "commentText": hi,
      "comentby": iu.email,
      "commetime": Timestamp.now()
    });
  }

  void togglelike() {
    setState(() {
      lik = !lik;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('post').doc(widget.postid);
    if (lik) {
      postRef.update({
        'likes': FieldValue.arrayUnion([iu.email])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([iu.email])
      });
    }
  }

  void showcmt() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('add commet'),
              content: TextField(
                controller: u,
                decoration: const InputDecoration(hintText: 'add a comment'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      aad(u.text);
                    },
                    child: const Text("post")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      u.clear();
                    },
                    child: const Text("cancel"))
              ],
            ));
  }

  void jfd() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              child: ListView(
                children: [
                  Center(child: const Text("Comments")),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("post")
                          .doc(widget.postid)
                          .collection("comments")
                          .orderBy("commetime", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Text("No comments yet.");
                        }
                        return Column(
                            children: snapshot.data!.docs.map((doc) {
                          final dc = doc.data() as Map<String, dynamic>;
                          return com(
                              co: dc["commentText"],
                              text: dc["comentby"],
                              time: formatdata(dc["commetime"]));
                        }).toList());
                      })
                ],
              ),
            ),
          );
        });
  }

  delp() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("delete post"),
              content: const Text("you sure about that"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("cancel")),
                TextButton(
                    onPressed: () async {
                      final comedox = await FirebaseFirestore.instance
                          .collection("post")
                          .doc(widget.postid)
                          .collection("comments")
                          .get();
                      for (var doc in comedox.docs) {
                        await FirebaseFirestore.instance
                            .collection("post")
                            .doc(widget.postid)
                            .collection("comments")
                            .doc(doc.id)
                            .delete();
                      }
                      FirebaseFirestore.instance
                          .collection("post")
                          .doc(widget.postid)
                          .delete()
                          .then((value) => print("nvnv"));

                      Navigator.pop(context);
                    },
                    child: const Text("delete")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: [FadeEffect(), ScaleEffect()],
      child: GestureDetector(
        onDoubleTap: jfd,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 173, 173),
              borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
          padding: const EdgeInsets.all(25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  like(
                    lik: lik,
                    ontap: togglelike,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.likes.length.toString(),
                      style: const TextStyle(fontSize: 9),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ctm(ontap: showcmt)
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 43, 43)),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.msg,
                        maxLines: 2,
                      ),
                      if (widget.user == iu.email?.split('@')[0]) del(ontap: delp)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
