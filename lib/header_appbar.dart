import 'package:flutter/material.dart';
import 'gradient_back.dart';

class HeaderAppBar extends StatelessWidget{
  // This class unifies the Gradeint background with the list view
  // of images in one single widget

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new GradientBack(),
    );
  }

}