import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'providers/provider.dart';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept' :'application/json',
  // 'Access-Control-Allow-Origin': "*",
};

Future<void> getNodeInfo(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/nodeget';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // int data= json.decode(response.body);
      List nodeData = List<dynamic>.from(data);
      print(nodeData);

      // 상태 관리 프로바이더에 데이터 전달
      Provider.of<StateProvider>(context, listen: false).tempData_e(nodeData);

    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}


Future<void> getData(BuildContext context) async {
  try {
    const String uri = '${Config.API_URL}/data/PRO001/original?from=1710255600000&to=1710341999000';
    final response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // int data= json.decode(response.body);
      List nodeData = List<dynamic>.from(data);
      print(nodeData);

      // 상태 관리 프로바이더에 데이터 전달
      Provider.of<StateProvider>(context, listen: false).tempData_e(nodeData);

    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}