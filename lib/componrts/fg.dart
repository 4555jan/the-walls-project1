import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tes/utils%20and%20otherfiles/li.dart';

class draw extends StatelessWidget {
  final void Function()?io;
  
  const draw({super.key,required this.io,});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Color.fromARGB(255, 65, 64, 64),
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 50,
       
          )),
          li(ICON:Icons.home, text: 'home',on:()=>Navigator.pop(context) ,),
         li(ICON: Icons.person, text: 'profile', on: io),
        
        ],
      ),
    );
  }
}
