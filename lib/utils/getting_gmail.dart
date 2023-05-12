import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
dynamic gmails = [];
Future<bool> getlist(gmail) async {
  final snapshots =
      await FirebaseDatabase.instance.ref().child("admins/1").get();
  debugPrint("snapshots" + snapshots.value.toString());
  if (snapshots.exists) {
    return true;
  }
  // await FirebaseDatabase.instance.ref().child('admins').once().then((value) {
  //   dynamic length = value.snapshot.children.length;
  //   for (int i = 1; i <= length; i++) {
  //     var data = value.snapshot.child(i.toString()).child('gmail').value;
  //     gmails.add(data);
  //   }
  // });
  //return gmails.contains(gmail) ? true : false;

  return false;
}

dynamic stugmails = [];
Future<int> getid() async {
  await FirebaseDatabase.instance.ref('Students').once().then((value) async {
    dynamic length = value.snapshot.children.length;
    for (int i = 1; i <= length; i++) {
      stugmails.add(value.snapshot.child(i.toString()).child('gmail').value);
    }
  });
  return (stugmails.indexOf(auth.currentUser!.email.toString()) + 1);
}

dynamic adgmails = [];
Future<int> getadid() async {
  await FirebaseDatabase.instance.ref('admins').once().then((value) async {
    dynamic length = value.snapshot.children.length;
    for (int i = 1; i <= length; i++) {
      stugmails.add(value.snapshot.child(i.toString()).child('gmail').value);
    }
  });
  return (stugmails.indexOf(auth.currentUser!.email.toString()) + 1);
}

Future getadloc() async {
  dynamic lat;
  dynamic log;
  await FirebaseDatabase.instance.ref('admins').once().then((value) async {
    lat = value.snapshot.child('1').child('latitute').value;
    log = value.snapshot.child('1').child('longitude').value;
  });
  List li = [lat, log];
  return li;
}
