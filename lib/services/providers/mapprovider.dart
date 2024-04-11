import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'dataprovider.dart';

class MapProvider extends ChangeNotifier {
  List _sensor = [];
  List get sensor => _sensor;
  Map<String, Map<String, String>> sensorNames = {}; // 리스트 대신 맵 사용
  List _sensorNamesList = [];
  List get sensorNamesList => _sensorNamesList;

  void tempSensor(data, BuildContext context) {
    _sensor = data;
    for (var data in _sensor) {
      String id = data['id'];
      String name = data['short_name'];
      // 영단어로 변환
      String englishName = Provider.of<DataProvider>(context, listen: false).convertToEnglish(name);
      int index = englishName.indexOf('(');
      String result = englishName.substring(0, index);
      if (!sensorNames.containsKey(id)) {
        sensorNames[id] = {}; // 리스트 대신 맵 초기화
      }
      // 이름과 타겟을 맵 형태로 추가
      sensorNames[id]?['name'] = result; // 리스트 대신 맵에 직접 추가
    }
    _sensorNamesList = sensorNames.values.map((e) => e['name']).toList();
    notifyListeners();
  }

  // 센서 선택
  List<bool> _sensorClicks = List.generate(12, (index) => false);
  List<bool> get sensorClicks => _sensorClicks;
  void onoffSensor(int idx) {
    // idx 패널을 클릭할 때마다 다른 패널들의 값을 false로 설정
    for (int i = 0; i < _sensorClicks.length; i++) {
      if (i != idx) {
        _sensorClicks[i] = false;
      }
    }
    // idx 패널의 값을 toggle
    _sensorClicks[idx] = !_sensorClicks[idx];
    notifyListeners();
  }

  // 선택한 센서 이름 저장
  String _tempName = "";
  String get tempName => _tempName;
  void tmpName(name){
    _tempName = name;
    notifyListeners();
  }

  // 편집 버튼 on/off
  bool _editClick = false;
  bool get editClick => _editClick;
  void onoffEdit(){
    _editClick = !_editClick;
    notifyListeners();
  }

  // map 페이지에서 노드 ID를 선택했을 때 선택한 노드 저장
  String? _selectedNode;
  String? get selectedNode=>_selectedNode;
  void saveNodeId(node){
    _selectedNode = node;
    notifyListeners();
  }

  // List<dynamic> _data = [];
  // List<dynamic> get data => _data;
  // void setData(){
  //   _data = [{'id': 'PRO001', 'setup_location': 'd'}, {'id': 'PRO002', 'setup_location': '비서실'}, {'id': 'PRO003', 'setup_location': '총무실옆방테이블위'}, {'id': 'PRO004', 'setup_location': '자재팀'}, {'id': 'PRO005', 'setup_location': '경비실'}, {'id': 'WAM001', 'setup_location': '1-배전반'}, {'id': 'WAM002',' setup_location': '2-배전반'}, {"id":" WAM003", 'setup_location': '3-배전반'}, {'id': 'WAM004', 'setup_location': '4-배전반'}, {'id': 'WAM005', 'setup_location': '5-배전반'}];
  //   notifyListeners();
  // }

  // String getSetupLocation(String? itemId, BuildContext context) {
  //   // itemId와 일치하는 아이템 찾기
  //   var item = Provider.of<MapProvider>(context).positionData
  //       .firstWhere((element) => element['id'] == itemId, orElse: () => {});
  //
  //   // setup_location 반환
  //   return item['setup_location'] ?? '';
  // }

  TextEditingController _locationController = TextEditingController();
  TextEditingController get locationController => _locationController;

  String _setup_location = "";
  String get setup_location => _setup_location;
  void setLocation(location){
    _setup_location = location;
    notifyListeners();
  }

  double _dx = 0;
  double get dx => _dx;
  double _dy = 0;
  double get dy => _dy;
  void setPosition(x,y){
    _dx = x;
    _dy = y;
    notifyListeners();
  }

  void resetLoPo(x,y){
    _dx = 0;
    _dy = 0;
    _setup_location = "";
    _locationController.clear();
    notifyListeners();
  }

  List _positionData = [];
  List get positionData => _positionData;
  void setPositionData(data){
    _positionData = data;
    notifyListeners();
  }

  // 원형에 커서 올렸을 때 사이즈 변경
  Map<int, bool> _hoveredStates = {};
  Map<int, bool> get hoveredStates => _hoveredStates;

  void setHovered(int index, bool isHovered) {
    _hoveredStates[index] = isHovered;
    notifyListeners();
  }

  bool isHovered(int index) => _hoveredStates[index] ?? false;

  // 원형 클릭 시 좌측상단에 데이터 패널 띄우기 위함
  int? _selectedCircleIndex;
  int? get selectedCircleIndex => _selectedCircleIndex;
  void selectCircle(int index){
    _selectedCircleIndex = index;
    notifyListeners();
  }
  void clearSelection(){
    _selectedCircleIndex =null;
    notifyListeners();
  }

  Map<String, dynamic>? getSelectedCircleData() {
    if (selectedCircleIndex == null) return null;
    return positionData[selectedCircleIndex!];
  }

  // 선택한 원형에 대한 노드 ID 저장
  String _clickNode = "";
  String get clickNode => _clickNode;
  void saveClickNode(node){
    _clickNode = node;
    print(_clickNode);
    notifyListeners();
  }

  void resetSelection(){
    _selectedCircleIndex = null;
    _clickNode = "";
    notifyListeners();
  }

}