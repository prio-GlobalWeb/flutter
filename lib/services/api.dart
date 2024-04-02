import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept' :'application/json',
  // 'Access-Control-Allow-Origin': "*",
};

//  회사별 장치의 노드 id 및 설치 위치 가져오기
Future<void> getNode(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/category';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // int data= json.decode(response.body);
      List nodeData = List<dynamic>.from(data);
      // 상태 관리 프로바이더에 데이터 전달
      Provider.of<DataProvider>(context, listen: false).tempData(nodeData);
    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}

// 각 장치의 수 가져오기
Future<void> getCount(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/categorycnt';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // int data= json.decode(response.body);
      List countData = List<dynamic>.from(data);
      // 상태 관리 프로바이더에 데이터 전달
      // 각 카테고리별로 개수를 가져와서 설정
      int? prioCount;
      int? wamonsCount;

      for (var entry in data) {
        final String category = entry['category'];
        final int count = int.parse(entry['count']);

        if (category == 'PRIO') {
          prioCount = count;
        } else if (category == 'WAMONS') {
          wamonsCount = count;
        }
      }

      // 가져온 데이터를 StateProvider에 전달
      Provider.of<DataProvider>(context, listen: false).lenSet(prioCount, wamonsCount);
    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}

//  각 장치에 대한 데이터 가져오기
// Future<void> getData(BuildContext context) async {
//   try {
//     const String uri = '${Config.API_URL}/call2';
//     final response = await http.get(
//       Uri.parse(uri),
//       headers: headers,
//     );
//     if (response.statusCode == 200) {
//       String responseData = utf8.decode(response.bodyBytes); // UTF-8로 명시적으로 디코딩
//       // List<String> dataList = responseData.split(',');
//       print(responseData);
//       // 데이터 처리
//       // 상태 관리 프로바이더에 데이터 전달
//       Provider.of<DataProvider>(context, listen: false).tempDatas(responseData);
//       // print(tempDataList);
//     } else {
//       print("불러오기 실패");
//     }
//   } catch (e) {
//     print("에러: $e");
//   }
// }

Future<void> getData(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/call';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List dataList = List<dynamic>.from(data);
      Provider.of<DataProvider>(context, listen: false).tempData_node(dataList, context);
    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러22: $e");
  }
}

// 센서 표기명
Future<void> getSensor(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/sensor';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List sensorData = List<dynamic>.from(data);
      // 각 id 별로 개수를 세는 맵을 생성
      Map<String, int> idCounts = {};
      // 데이터를 순회하며 id 별 개수를 세기
      for (var sensor in sensorData) {
        String id = sensor['id'];
        idCounts[id] = (idCounts[id] ?? 0) + 1;
      }
      // 가져온 데이터를 StateProvider에 전달
      Provider.of<DataProvider>(context, listen: false).tempSensor(sensorData);
      Provider.of<DataProvider>(context, listen: false).setSensorCnt(idCounts);
    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}