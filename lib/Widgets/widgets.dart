import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'AdminHome.dart';
import 'colors.dart';

var adminstubackGroundGradientColor = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
      // Colors.white,
      lightOrange,
      Colors.white,
      Colors.white,
      Color(0xff034B60),

      // Color(0xffFFA624),
    ]));
var adminbackGroundGradientColor = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
      // Colors.white,
      Colors.white,
      Colors.white,
      Color(0xff034B60),

      // Color(0xffFFA624),
    ]));

var StudentsbackGroundGradientColor = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
      // Colors.white,
      Colors.white,
      Colors.white,
      // Color(0xff034B60),
      lightOrange
      // Color(0xffFFA624),
    ]));

RippleAnimation rippleAnimation() {
  return const RippleAnimation(
    color: Colors.lightBlue,
    delay: Duration(milliseconds: 300),
    repeat: true,
    minRadius: 75,
    ripplesCount: 6,
    duration: Duration(milliseconds: 6 * 300),
    child: Icon(
      Icons.location_searching,
    ),
  );
}

TextButton appBarButton(
    {required IconData iconData,
    required Function() callBack,
    required Color iconColor}) {
  return TextButton(
    onPressed: callBack,
    child: Icon(
      iconData,
      color: iconColor,
    ),
  );
}

void bottomSheet() {
  DatabaseReference ref = FirebaseDatabase.instance.ref('Students');
  Get.bottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.white,
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Present Students',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                print(snapshot.child('status').value.toString());
                return (snapshot.child('status').value.toString() == 'present')
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: ListTile(
                          title: Text("Name : ${snapshot.child('name').value}"),
                          trailing: Text(
                              "Roll no : ${snapshot.child('roll_no').value}"),
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ),
          Row(
            children: [
              HomeReuseableMaterialButton(
                  clr: lightOrange, buttonText: 'Status', callback: () {}),
              const SizedBox(
                width: 5,
              ),
              HomeReuseableMaterialButton(
                  clr: Colors.green,
                  buttonText: 'Submit Attendence',
                  callback: () {})
            ],
          ),
        ],
      ),
    ),
  );
}

class ReuseableMaterialButton extends StatelessWidget {
  ReuseableMaterialButton(
      {super.key,
      this.height,
      required this.buttonText,
      required this.callback,
      this.width,
      this.clr,
      this.loading,
      required this.heroTag});

  String? buttonText;
  bool? loading = false;
  Function()? callback;

  double? height;
  double? width;
  Color? clr;

  var heroTag;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        width: width,
        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            color: clr,
            child: MaterialButton(
              onPressed: callback,
              child: loading == true
                  ? CircularProgressIndicator(
                      color: darkBlue,
                    )
                  : Text(buttonText.toString()),
            )),
      ),
    );
  }
}

class HomeReuseableMaterialButton extends StatelessWidget {
  HomeReuseableMaterialButton(
      {super.key,
      this.height,
      required this.buttonText,
      required this.callback,
      this.width,
      this.clr,
      this.loading});

  String? buttonText;
  bool? loading = false;
  Function()? callback;

  double? height;
  double? width;
  Color? clr;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        width: width,
        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            color: clr,
            child: MaterialButton(
              onPressed: callback,
              child: loading == true
                  ? CircularProgressIndicator(
                      color: darkBlue,
                    )
                  : Text(buttonText.toString()),
            )),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  Textfield(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.labelValidator,
      required this.icon,
      this.obscureText = false});
  TextEditingController controller;
  String labelText;
  String labelValidator;
  IconData icon;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusColor: darkBlue,
          prefixIcon: Icon(
            icon,
            size: 25,
            // color: Colors.grey,
          ),
          // prefixIconColor: darkBlue,
          // labelText: labelText,
          hintText: labelText, prefixIconColor: darkBlue,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkBlue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkBlue, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        validator: ((value) {
          if (value!.isEmpty) {
            return labelValidator;
          }
          return null;
        }),
      ),
    );
  }
}

adminOrStudentPageDecision({required String errorMsg}) {
  Get.defaultDialog(
      middleText: errorMsg,
      confirm: TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.black),
          )),
      backgroundColor: Colors.red);
}
