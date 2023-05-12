import 'package:attendence_app/Widgets/colors.dart';
import 'package:attendence_app/Widgets/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // const SignupPage({super.key});
  final _formkey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final rollnoController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminstubackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Sign up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: darkBlue),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Textfield(
                              controller: nameController,
                              labelText: 'Name',
                              labelValidator: 'Enter name',
                              icon: Icons.abc,
                            ),
                            Textfield(
                                controller: rollnoController,
                                labelText: 'Roll no',
                                labelValidator: "Enter Roll no",
                                icon: Icons.numbers),
                            Textfield(
                              controller: emailController,
                              labelText: 'Email',
                              labelValidator: "Enter Email",
                              icon: Icons.email_outlined,
                            ),
                            Textfield(
                              controller: passController,
                              labelText: 'Password',
                              labelValidator: "Enter password",
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    ReuseableMaterialButton(
                        heroTag: 'studentTag',
                        loading: loading,
                        clr: lightOrange,
                        width: double.infinity,
                        buttonText: 'Sign Up',
                        callback: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            auth
                                .createUserWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password: passController.text.toString())
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              print("Sucessfully");
                              Get.back();
                              print('pop');
                              Get.snackbar('Account Created', "Sucessfully",
                                  backgroundColor: Colors.green);
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref('Students');
                              ref.once().then((value) async {
                                int len = value.snapshot.children.length;
                                ref.child((len + 1).toString()).set({
                                  'name': nameController.text.toString(),
                                  'roll_no': rollnoController.text.toString(),
                                  'gmail': emailController.text.toString(),
                                  'latitute': 0,
                                  'longitude': 0,
                                  'status': 'absent'
                                });
                              });
                            }).onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text(
                                          'Email already exist or password should be 6 char long'),
                                    );
                                  });
                            });
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account'),
                        TextButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed('/loginPage',
                                  arguments: ['Student Login']);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: darkBlue),
                            ))
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
