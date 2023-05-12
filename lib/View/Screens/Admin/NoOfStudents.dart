import 'package:attendence_app/Widgets/colors.dart';
import 'package:attendence_app/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class NoOfStuds extends StatefulWidget {
  const NoOfStuds({super.key});

  @override
  State<NoOfStuds> createState() => _NoOfStudsState();
}

class _NoOfStudsState extends State<NoOfStuds> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: StudentsbackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Students',
          ),
          centerTitle: true,
          backgroundColor: darkBlue,
        ),
        body: ListView(
          children: [
            for (var i = 0; i < 76; i++)
              Card(
                elevation: 5,
                child: ListTile(
                  title: Text("Name : " + (i + 1).toString()),
                  trailing: Text('Roll no'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
