import 'package:flutter/material.dart';
import 'package:prio_web/services/provider.dart';
import 'package:provider/provider.dart';

ElevatedButton mapBtn(){
  return ElevatedButton(
    onPressed: (){debugPrint("Go to Map page");},
    child: Text(
      'MAP',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 15,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
  ),
  );
}

ElevatedButton csvBtn(){
  return ElevatedButton(
    onPressed: (){debugPrint("Go to CSV");},
    child: Text(
      'CSV',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 15,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
  );
}

ElevatedButton recordBtn(){
  return ElevatedButton(
    onPressed: (){debugPrint("Go to Record");},
    child: Text(
      'Record',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 15,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
  );
}

ElevatedButton graphBtn(BuildContext context){
  return ElevatedButton(
    onPressed: (){debugPrint("Go to Graph");},
    child: Text(
      '${Provider.of<StateProvider>(context, listen: false).isClick ? 'Cancel' :  'Graph'}',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 15,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
  );
}