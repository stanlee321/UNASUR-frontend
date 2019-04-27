import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //height: 250.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
            Color(0xFF4268D3),
            Color(0xFF584CD1)
          ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
          stops: [0.0, 0.6],
          tileMode: TileMode.clamp
          )
      ),
      
      child: Text(
        'Sistema Domótico UNASUR',
        style: TextStyle(
          color: Colors.white,
          fontSize: 70.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center
      ),
      alignment: Alignment(0.0, -0.6),

    );
  }
}
