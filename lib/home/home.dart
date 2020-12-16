import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/robot_colorsl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color:RobotColors.primaryColor1,


    );
  }
}