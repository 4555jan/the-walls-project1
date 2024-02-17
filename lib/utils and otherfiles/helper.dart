import 'package:cloud_firestore/cloud_firestore.dart';
String formatdata(Timestamp timestamp){
DateTime dateTime=timestamp.toDate();
String year=dateTime.year.toString();
String time=dateTime.month.toString();
String yea=dateTime.day.toString();

String formatdata= yea+"/"+time+"/"+year;
return formatdata;
}