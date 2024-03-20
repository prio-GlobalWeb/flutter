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
      print("${prioCount}, ${wamonsCount}");
      print("${Provider.of<DataProvider>(context, listen: false).prioLen}, ${Provider.of<DataProvider>(context, listen: false).wamonsLen}");

    } else {
      print("불러오기 실패");
    }
  } catch (e) {
    print("에러: $e");
  }
}