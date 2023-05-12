import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/colors.dart';
import '../../Widgets/widgets.dart';

class AdminStudentScreen extends StatefulWidget {
  const AdminStudentScreen({super.key});

  @override
  State<AdminStudentScreen> createState() => _AdminStudentScreenState();
}

class _AdminStudentScreenState extends State<AdminStudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminstubackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                      tag: 'image',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                            Image.asset('assets/images/login.png', height: 100),
                      )),
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: darkBlue),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ReuseableMaterialButton(
                heroTag: 'adminTag',
                width: double.infinity,
                buttonText: 'Admin',
                callback: () {
                  Get.toNamed('/loginPage', arguments: ['Admin Login']);
                },
              ),
              SizedBox(
                height: 20,
              ),
              ReuseableMaterialButton(
                heroTag: 'studentTag',
                clr: lightOrange,
                width: double.infinity,
                buttonText: 'Student',
                callback: () {
                  Get.toNamed('/loginPage', arguments: ['Student Login']);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
