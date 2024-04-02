import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:prio_web/widgets/avgstatus.dart';

class DataProvider extends ChangeNotifier {
  // prio 및 wamons 몇 개인지 확인
  List _panelData = [];
  List get panelData => _panelData;
  List _nodes = [];
  List get nodes => _nodes;

  void tempData(data) {
    _panelData = data;
    // 조회된 데이터에서 노드 값만 별도의 리스트로 저장
    // 초기 화면의 상태 색상을 구하기 위함
    _nodes = data.map((item) => item['id']).toList();
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

  List<Map<String, String>> _sensorData = [];
  List<Map<String, String>> get sensorData => _sensorData;

  List<String> returnName(id) {
    _sensorData = sensorNames[id] ?? [];
    print(_sensorData); // 이름, 슬롯넘버
    List<String> names = [];
    for (var data in _sensorData) {
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

  // api 호출 후 해당 함수를 통해 데이터를 저장할 때
  // 점수 계산 및 색상 상태 반환
  void tempData_node(data, BuildContext context) {
    _tempNodeData = data;
    initColor(context, _nodes);
    notifyListeners();
  }

  // 초기 웹 페이지 실행 시 각 노드별 점수에 따른 색상을 구하기 위함
  void initColor(BuildContext context, List nodes) {
    nodes.forEach((node) {
      _nodeData = _tempNodeData.firstWhere((item) => item['node'] == node,
          orElse: () => null);
      if (_nodeData != null) {
        // print(_nodeData);
        setDataMap(context, node);
      } else {
        print('Node data not found for node: $node');
      }
    });
  }

  // sensor의 slot_number와 동일한 file_name의 file_data만 맵으로 묶기
  void setDataMap(BuildContext context, String node){
    _fileDataMap = {};
    var datas = _nodeData['datas'];
    var slotNumbers = sensorNames[node]!.map((item) => item['slot_number']).toList();
    for (var data in datas) {
      var files = data['files'];
      for (var file in files) {
        var filename = file['file_name'].toString();
        var filedata = file['file_data'];

        // 주어진 노드의 sensorNames에 있는 slot_number에 대해서만 처리
        if (slotNumbers.contains(filename)) {
          if (!_fileDataMap.containsKey(filename)) {
            _fileDataMap[filename] = [filedata.toDouble()];
          } else {
            _fileDataMap[filename]!.add(filedata.toDouble());
          }
        }
      }
    }
    calScore(_fileDataMap, context, node);
  }

  // 주어진 노드에 대한 마지막 데이터 출력
  returnData_node(node, BuildContext context) {
    _fileData = [];
    _nodeData = _tempNodeData.firstWhere((item) => item['node'] == node,
        orElse: () => null);
    setDataMap(context, _node!);
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
    print(fileData);
  }

  Map<String, int> _scores = {};
  Map<String, int> get scores => _scores;
  int _sum = 0;
  int get sum => _sum;
  // 초기 웹 페이지 전체적인 노드별 점수 저장용
  Map<String, int> _nodeSums = {};
  Map<String , int> get nodeSums => _nodeSums;

  // 실행 할 때마다 저장되있던 점수 제거
  // 초기화 안하면 점수 계속 더해짐
  void resetSum(){
    _sum = 0;
    notifyListeners();
  }

  // 각각의 점수 저장 및 총점 저장
  void saveScores(String key, int score, String node){
    _scores[key] = score;
    _sum += score;
    _nodeSums[node] = _sum;
    notifyListeners();
  }
}