import 'package:attendence_app/View/auth/LoginPage.dart';
import 'package:attendence_app/View/auth/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'View/Screens/admin_Student_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/",
          page: () => const AdminStudentScreen(),
        ),
        GetPage(
          name: "/loginPage",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/SignUpPage",
          page: () => SignupPage(),
        ),
      ],
    );
  }
}
