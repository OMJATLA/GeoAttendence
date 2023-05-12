import 'dart:async';
import 'package:attendence_app/Widgets/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../Widgets/widgets.dart';
import '../../../utils/distance_cal.dart';
import '../../../utils/getting_gmail.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  Position? position;

  Future getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  final databaseref = FirebaseDatabase.instance.ref('Students');
  int? id;
  dynamic lati = 0;
  dynamic logi = 0;
  dynamic distancecal = 0;
  bool startAttendence = false;

  @override
  void initState() {
    super.initState();
    getid().then((value) async {
      id = await value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: adminstubackGroundGradientColor,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: const Text('Welcome back',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      subtitle: Text(
                        auth.currentUser!.email.toString() +
                            "\n\n${distancecal.toString()}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Timer.periodic(Duration(seconds: 3), (timer) async {
                  //       await getLocation();
                  //       databaseref.child(id.toString()).update({
                  //         'latitute': position!.latitude,
                  //         'longitude': position!.longitude,
                  //       });
                  //       distanceassign();
                  //     });
                  //   },
                  //   child: const Text('Start'),
                  // ),
                  startAttendence ? rippleAnimation() : Container(),
                  FirebaseAnimatedList(
                      query: databaseref,
                      itemBuilder: (context, snapshot, animation, index) {
                        if (snapshot.key == id.toString()) {
                          lati = snapshot.child('latitute').value;
                          logi = snapshot.child('longitude').value;
                        }
                        return Container(
                          height: 0,
                          width: 0,
                        );
                      }),

                  ReuseableMaterialButton(
                      buttonText: startAttendence ? "Stop" : 'Start',
                      callback: () {
                        setState(() {
                          startAttendence
                              ? startAttendence = false
                              : startAttendence = true;
                        });

                        Timer.periodic(Duration(seconds: 3), (timer) async {
                          if (startAttendence == false) timer.cancel();
                          await getLocation();
                          databaseref.child(id.toString()).update({
                            'latitute': position!.latitude,
                            'longitude': position!.longitude,
                          });
                          distanceassign();
                        });
                      },
                      heroTag: '',
                      clr: startAttendence ? Colors.red : lightOrange),
                ],
              ),
            )),
      ),
    );
  }

  Future distanceassign() async {
    dynamic loc = await getadloc();
    setState(() {
      distancecal = distance(lati, logi, loc[0], loc[1]) * 1000;
      distancecal < 25
          ? databaseref.child(id.toString()).update({'status': 'present'})
          : {};
    });
  }

  @override
  void dispose() {
    super.dispose();
    databaseref
        .child(id.toString())
        .update({'latitute': 0, 'longitude': 0, 'status': 'absent'});
  }
}
