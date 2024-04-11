import 'package:flutter/material.dart';
import 'package:prio_web/main.dart';
import 'package:prio_web/map.dart';
import 'package:prio_web/services/api/map-api.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:provider/provider.dart';

import '../services/providers/dataprovider.dart';
import '../services/providers/mapprovider.dart';

ElevatedButton mapBtn(BuildContext context){
  final stateProvider = Provider.of<StateProvider>(context, listen: false);
  final dataProvider = Provider.of<DataProvider>(context);
  return ElevatedButton(
    onPressed: (){
      stateProvider.resetPanel();// count가 2일 때는 count 초기화
      stateProvider.click(3);
      if(stateProvider.selectedPanel != -1 || stateProvider.selectedPanel2  != -1){
        stateProvider.selectedPanel_f();
        stateProvider.selectedPanel2_f();
        stateProvider.unselectedPanel();
        stateProvider.unselectedPanel2();
      }
      dataProvider.resetData();

      navigatorKey.currentState?.push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return MapPage(); // 이동할 페이지 위젯
          },
          transitionDuration: Duration(milliseconds: 0), // 전환 시간 설정 (0으로 설정하여 효과를 없앰)
        ),
      );
    },
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

ElevatedButton editBtn(BuildContext context){
  return ElevatedButton(
    onPressed: (){
      Provider.of<MapProvider>(context, listen: false).onoffEdit();
    },
    child: Text(
      'Edit',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 17,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Provider.of<MapProvider>(context, listen: false).editClick ?Colors.black12 :Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
  );
}

ElevatedButton saveBtn(BuildContext context){
  final stateProvider = Provider.of<StateProvider>(context, listen: false);
  final dataProvider = Provider.of<DataProvider>(context);
  final mapProvider = Provider.of<MapProvider>(context);
  return ElevatedButton(
    onPressed: (){
      if(mapProvider.setup_location.isNotEmpty&&mapProvider.selectedNode!.isNotEmpty &&mapProvider.dx != 0 && mapProvider.dy !=0){
        setPosition(context);
      }
      else{
        print("저장 실패");
      }
    },
    child: Text(
      'Save',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 17,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor:Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
  );
}

ElevatedButton resetBtn(BuildContext context, double dx, double dy){
  return ElevatedButton(
    onPressed: (){
      Provider.of<MapProvider>(context, listen: false).resetLoPo(dx, dy);
    },
    child: Text(
      'Reset',
      style: TextStyle(
        fontFamily: 'shsN',
        fontSize: 17,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor:Color(0xff78b4f0),
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
  );
}