import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:prio_web/widgets/avgstatus.dart';

class DataProvider extends ChangeNotifier {
  // prio 및 wamons 몇 개인지 확인
  List _panelData = [];

  List get panelData => _panelData;

  void tempData(data) {
    _panelData = data;
    notifyListeners();
  }

  int? _prioLen;

  int? get prioLen => _prioLen;
  int? _wamonsLen;

  int? get wamonsLen => _wamonsLen;

  void lenSet(prio, wamons) {
    _prioLen = prio;
    _wamonsLen = wamons;
    notifyListeners();
  }

  // 선택한 패널의 nodeid와 설치 장소 저장
  String? _location;

  String? get location => _location;
  String? _node;

  String? get node => _node;

  void setData(location, node) {
    _location = location;
    _node = node;
    notifyListeners();
  }

  void resetData() {
    _location = null;
    _node = null;
    notifyListeners();
  }

  // 각 장치에 대한 측정 값 저장
  List _datas = [];

  List get datas => _datas;

  void tempDatas(data) {
    _datas = data;
    notifyListeners();
  }

  // 가져온 센서 저장 및 노드에 대한 센서 이름 저장
  List _sensor = [];

  List get sensor => _sensor;

  Map<String, List<Map<String, String>>> sensorNames = {};

  void tempSensor(data) {
    _sensor = data;
    for (var data in _sensor) {
      String id = data['id'];
      String name = data['short_name'];
      String target = data['target'] ?? "";
      String number = data['slot_number'] ?? "";
      // 영단어로 변환
      String englishName = convertToEnglish(name);
      if (!sensorNames.containsKey(id)) {
        sensorNames[id] = [];
      }
      // 이름과 타겟을 맵 형태로 추가
      sensorNames[id]?.add({'name': englishName, 'target': target, 'slot_number' : number});
    }
    notifyListeners();
  }

  List<String> returnName(id) {
    List<Map<String, String>> sensorData = sensorNames[id] ?? [];
    List<String> names = [];
    for (var data in sensorData) {
      if (data.containsKey('name')) {
        names.add(data['name']!);
      }
    }
    return names;
  }

  List<String> returnTarget(id) {
    List<Map<String, String>> sensorData = sensorNames[id] ?? [];
    List<String> targets = [];
    for (var data in sensorData) {
      if (data.containsKey('target') && data['target'] != "") {
        targets.add(data['target']!);
      }
    }
    return targets;
  }

  String convertToEnglish(String name) {
    switch (name) {
      case '조도':
        return 'Illuminance (lux)';
      case '온도':
        return 'Temperature (°C)';
      case '습도':
        return 'Humidity (%)';
      case '라돈':
        return 'Radon (Bq/㎡)';
      case 'TVOC':
        return 'TVOC (ppb)';
      case 'CO':
        return 'CO (ppm)';
      case 'CO2':
        return 'CO2 (ppm)';
      case 'PM10':
        return 'PM10 (㎍/m³)';
      case 'PM2.5':
        return 'PM2.5 (㎍/m³)';
      case '전류':
        return 'electric current (A)';
      case '진동':
        return 'vibration (g)';
      case '기울기':
        return 'inclination (˚)';
      default:
        return name;
    }
  }

  //  노드에 대해 설정된 센서 수 반환
  List<Map<String, dynamic>> _sensorCnt = [];
  List<Map<String, dynamic>> get sensorCnt => _sensorCnt;

  void setSensorCnt(Map<String, int> data) {
    // Map을 List<Map<String, dynamic>> 형태로 변환하여 저장
    _sensorCnt = data.entries.map((entry) {
      return {'id': entry.key, 'count': entry.value};
    }).toList();

    notifyListeners();
  }

  int returnCnt(String id) {
    for (var sensorData in _sensorCnt) {
      if (sensorData['id'] == id) {
        return sensorData['count'];
      }
    }
    return 0;
  }

  // 변환 데이터 저장
  List _tempNodeData = [];
  List get tempNodeData => _tempNodeData;
  // 노드별 최근 데이터 저장
  List _returnData =[];
  List get returnData => _returnData;
  // 센서의 slot_number와 마지막 데이터에서 file_name이 동일한 데이터 저장
  List<Map<String, dynamic>> _fileData = [];
  List<Map<String, dynamic>> get fileData => _fileData;
  dynamic _nodeData;
  dynamic get nodeData => _nodeData;
  // file_name 별 file_data 저장
  Map<String, List<double>> _fileDataMap = {};
  Map<String, List<double>> get fileDataMap => _fileDataMap;

  void tempData_node(data) {
    _tempNodeData = data;
    notifyListeners();
  }

  void setDataMap(BuildContext context){
    _fileDataMap = {};
    var datas = _nodeData['datas'];
    for(var data in datas){
      var files = data['files'];
      for(var file in files){
        var filename = file['file_name'].toString();
        var filedata = file['file_data'];

        if(!fileDataMap.containsKey(filename)){
          fileDataMap[filename] = [filedata.toDouble()];
        }else{
          fileDataMap[filename]!.add(filedata.toDouble());
        }
      }
    }
    calCOorTVOC(fileDataMap, context);
  }

  // 주어진 노드에 대한 마지막 데이터 출력
  returnData_node(node, BuildContext context) {
    _fileData = [];
    _nodeData = _tempNodeData.firstWhere((item) => item['node'] == node,
        orElse: () => null);
    setDataMap(context);
    // print(_nodeData);
    // tempScore(context);
    // 노드의 데이터가 존재한다면
    if (_nodeData != null) {
      // 마지막 datas의 files 부분만 추출
      _returnData = _nodeData['datas'].last['files'];

      // _returnData가 null이 아닌 경우에만 for 루프 실행
      if (_returnData != null) {
        for (var sensor in sensorNames[node]!) {
          // sensor의 slot_number가 _returnData에 있는지 확인
          int cnt = _returnData.length;
          for(int i = 0; i <cnt; i++){
            if(sensor['slot_number'].toString()==_returnData[i]['file_name'].toString()) {
              _fileData.add({
                'file_name': _returnData[i]['file_name'],
                'file_data': _returnData[i]['file_data']
              });
            }
          }
        }
      }
    }else{
      for(int i = 0; i < returnCnt(node);i++){
        _fileData.add({'file_name': 0});
      }
    }
  }

}