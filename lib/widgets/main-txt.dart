import 'package:flutter/material.dart';

// main-top
Text lang_txt(String txt,){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsR',
      fontSize: 16,
    ),
  );
}

Text username_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsB',
      fontSize: 16,
    ),
  );
}

// main-left
Text ins_name(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsB',
      fontSize: 18,
    ),
  );
}

Text nodeid(String txt){
  return Text(
    'PRIO ' + txt,
    style: TextStyle(
      fontFamily: 'shsR',
      fontSize: 15,
    ),
  );
}

Text prio_status(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsB',
      fontSize: 20,
    ),
  );
}

Text type_txt(List types, int idx){
  return Text(
    types[idx],
    style: TextStyle(
      fontFamily: 'shsR',
      fontSize: 16,
      color: Color(0xff868a90),
    ),
  );
}

Text chart_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsM',
      fontSize: 18,
    ),
  );
}

Text pietitle_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsM',
      fontSize: 16,
    ),
  );
}

// main-right
Text time_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsN',
      fontSize: 18,
    ),
  );
}

Text device_count_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsM',
      fontSize: 20,
    ),
  );
}

Text prio_txt(String txt){
  return Text(
     'PRIO ' + txt,
    style: TextStyle(
      fontFamily: 'shsR',
      fontSize: 16,
    ),
  );
}

Text prio_ins_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsB',
      fontSize: 20,
    ),
  );
}

Text wamons_txt(String txt){
  return Text(
    'WAMONS ' + txt,
    style: TextStyle(
      fontFamily: 'shsR',
      fontSize: 16,
    ),
  );
}

Text wamons_ins_txt(String txt){
  return Text(
    txt,
    style: TextStyle(
      fontFamily: 'shsB',
      fontSize: 20,
    ),
  );
}

TextStyle textStyle(){
  return TextStyle(
    fontFamily: 'shsM',
    fontSize: 15,
  );
}