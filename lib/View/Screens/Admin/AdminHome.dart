import 'dart:async';

import 'package:attendence_app/Widgets/colors.dart';
import 'package:attendence_app/Widgets/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../utils/getting_gmail.dart';
import 'NoOfStudents.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool checkAttendence = false;
  final databaseref = FirebaseDatabase.instance.ref('admins');
  int? id;
  Position? position;

  Future getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getadid().then((value) async {
      id = await value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminbackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: appBarButton(
              iconData: Icons.add_to_home_screen,
              callBack: () {
                checkAttendence = false;
                setState(() {});
              },
              iconColor: lightOrange),
          title: const Text(
            'Admin',
          ),
          centerTitle: true,
          // backgroundColor: Color(0xffF0ECCF),
          backgroundColor: darkBlue,
          actions: [
            TextButton(onPressed: () {}, child: Icon(Icons.account_circle))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HomeReuseableMaterialButton(
                      // clr: Color(0xffFD8A8A),
                      clr: lightOrange,
                      height: 80,
                      width: 200,
                      buttonText: 'No of Students',
                      callback: () {
                        Get.to(NoOfStuds());
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  HomeReuseableMaterialButton(
                      clr: checkAttendence ? Colors.red : lightOrange,
                      height: 80,
                      width: 200,
                      buttonText: checkAttendence
                          ? 'Stop Attendence'
                          : 'Check Attendence',
                      callback: () async {
                        await Geolocator.requestPermission();

                        setState(() {
                          checkAttendence
                              ? checkAttendence = false
                              : checkAttendence = true;
                        });

                        Timer.periodic(Duration(seconds: 3), (timer) async {
                          if (checkAttendence == false) timer.cancel();
                          await getLocation();
                          print(position);
                          databaseref.child(id.toString()).update({
                            'latitute': position!.latitude,
                            'longitude': position!.longitude,
                          });
                        });
                      }),
                ],
              ),
              checkAttendence ? rippleAnimation() : SizedBox(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: checkAttendence ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  child: Text(
                    'Mark Attendenece',
                    style: TextStyle(
                        color: checkAttendence
                            ? Colors.black
                            : Color.fromARGB(255, 117, 114, 114)),
                  ),
                  onPressed: () {
                    if (checkAttendence) bottomSheet();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
