import 'package:flutter/material.dart';

Text sensorText(String txt, Color color){
  return Text(
    txt,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'shsM',
      fontSize: 15,
      color: color,
    ),
  );
}

// map-panel
Text map_insName(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsB',
      fontSize: 18,
    ),
  );
}

Text map_nodeid(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsR',
      fontSize: 15,
    ),
  );
}
