import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../providers/mapprovider.dart';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept' :'application/json',
  // 'Access-Control-Allow-Origin': "*",
};

// 센서 표기명
Future<void> mapSensor(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/mapsensor';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List sensorData = List<dynamic>.from(data);

      Provider.of<MapProvider>(context, listen: false).tempSensor(sensorData, context);

    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}

// 위치 값
Future<void> mapPosition(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/position';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List positionData = List<dynamic>.from(data);

      Provider.of<MapProvider>(context, listen: false).setPositionData(positionData);

    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}

// 지도에 위치 등록
Future<void> setPosition(BuildContext context) async {
  final Map<String, dynamic> position = {
    'id': Provider.of<MapProvider>(context, listen: false).selectedNode,
    'setup_location':Provider.of<MapProvider>(context, listen: false).setup_location,
    'position_x' : Provider.of<MapProvider>(context, listen: false).dx,
    'position_y' :Provider.of<MapProvider>(context, listen: false).dy,
  };
  try {
    const String uri = '${Config.API_URL}/save';
    final response =  await http.post(
      Uri.parse(uri), headers: headers,
      body: jsonEncode(position),
    );
    var jsonResponse = jsonDecode(response.body);
    int result = jsonResponse;
    if(result == 1){
      print("success");
    } else {
      print("fail");
    }
  } catch (e) {
    print("에러: $e");
  }
}