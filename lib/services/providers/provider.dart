import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:provider/provider.dart';

class StateProvider extends ChangeNotifier{
  DateTime? _current = DateTime.now();
  DateTime? get current=> _current;
  void getCurrent(){
    _current = DateTime.now();
    notifyListeners();
  }

  String? _selectedValue;
  String? get selectedValue => _selectedValue;

  void selectValue(String value){
    _selectedValue = value;
    notifyListeners();
  }

  String? _selectedValue2;
  String? get selectedValue2 => _selectedValue2;
  int _coloridx = 0;
  int get coloridx => _coloridx;
  Color _color = Color(0xffffffff);
  Color get color => _color;

  void selectValue2(String value){
    _selectedValue2 = value;
    if(value == "Very Good"){
      _coloridx = 1;
      _color = Color(0xff4e92fd);
    }
    if(value == "Good"){
      _coloridx = 2;
      _color = Color(0xff4fec76);
    }
    if(value == "Bad") {
      _coloridx = 3;
      _color = Color(0xffee8b60);
    }
    if(value == "Very Bad"){
      _coloridx = 4;
      _color = Color(0xffff5963);
    }
    notifyListeners();
  }

  List<bool> _panelClicks = List.generate(13, (index) => false);
  List<bool> get panelClicks => _panelClicks;
  List<bool> _panelClicks2 = List.generate(11, (index) => false);
  List<bool> get panelClicks2 => _panelClicks2;
  int _selectedPanel = -1;
  int get selectedPanel => _selectedPanel;
  int _selectedPanel2 = -1;
  int get selectedPanel2 => _selectedPanel2;
  int _count = 0;
  int get count => _count;

  void resetPanel(){
    _count = 0;
    notifyListeners();
  }

  void selectedPanel_f(){
    if (_selectedPanel != -1) {
      _panelClicks[_selectedPanel] = false;
      notifyListeners();
    }
  }
  void unselectedPanel2(){
    if (_selectedPanel2 != -1) {
      _panelClicks2[_selectedPanel2] = false;
      notifyListeners();
    }
  }

  void updatedPanel(int idx){
    if (_selectedPanel == idx) {
      _count++; // 패널을 누를 때마다 count 증가
    } else {
      _count = 1; // 새로운 패널을 눌렀을 때는 count 초기화
    }
    // 1번째 패널 클릭 후 와몬스 클릭 후 다시 프리오 1번 클릭 시
    // selectedPanel 값이 이전과 동일해서 패널 선택이 제대로 안되는 문제 발생
    _selectedPanel = idx;
    _panelClicks[idx] = !panelClicks[idx];
    notifyListeners();
  }

  void selectedPanel2_f(){
    if (_selectedPanel2 != -1) {
      _panelClicks2[_selectedPanel2] = false;
      notifyListeners();
    }
  }
  void unselectedPanel(){
    if (_selectedPanel != -1) {
      _panelClicks[_selectedPanel] = false;
      notifyListeners();
    }
  }
  void updatedPanel2(int idx){
    if (_selectedPanel2 == idx) {
      _count++; // 패널을 누를 때마다 count 증가
    } else {
      _count = 1; // 새로운 패널을 눌렀을 때는 count 초기화
    }
    _selectedPanel2 = idx;
    _panelClicks2[idx] = !panelClicks2[idx];
    notifyListeners();
  }

  bool _isClick = false;
  bool get isClick => _isClick;
  void checkClick(){
    _isClick = !_isClick;
    notifyListeners();
  }

  bool _prioClick = false;
  bool get prioClick => _prioClick;
  bool _wamonsClick = false;
  bool get wamonsClick => _wamonsClick;
  void click(int idx) {
    if (idx == 1) {
      _prioClick = true;
      _wamonsClick = false;
    } else if (idx == 2) {
      _prioClick = false;
      _wamonsClick = true;
    } else if (idx == 3) {
      _prioClick = false;
      _wamonsClick = false;
    }
    notifyListeners();
  }

  Map<Color, String> colorText = {
    Color(0xff4e92fd) : "Very Good",
    Color(0xff4fec76) :"Good",
    Color(0xffee8b60) : "Bad",
    Color(0xffff5963) : "Very Bad",
  };

  // 제품 상태별 색상 반환 함수
  statusColor(int sum){
    if(sum >= 90){
      return Color(0xff4e92fd);
    }
    else if(sum >= 80){
      return Color(0xff4fec76);
    }
    else if(sum >= 70){
      return Color(0xffee8b60);
    }
    else{
      return Color(0xffff5963);
    }
  }

  Map<String, Color> getNodeColorMap(Map<String, int> nodeSumMap, category, BuildContext context) {
    Map<String, Color> nodeColorMap = {};
    List filteredData = Provider.of<DataProvider>(context).panelData
        .where((data) => data['category'] == category).toList();
    filteredData.forEach((data) {
      String node = data['id'];
      int sum = nodeSumMap[node] ?? 0;
      Color color = statusColor(sum);
      nodeColorMap[node] = color;
    });
    return nodeColorMap;
  }

  Map<String, double> _values = {};
  Map<String, double> get values => _values;

  Map<String, double> getColorTextCounts(Map<String, Color> nodeColorMap, Map<Color, String> colorText) {
    // 원하는 순서대로 요소를 추가하기 위해 LinkedHashMap을 사용합니다.
    Map<String, double> colorTextCounts = LinkedHashMap<String, double>();
    colorText.forEach((color, text) {
      double count = nodeColorMap.values.where((c) => c == color).length.toDouble();
      colorTextCounts[text] = count;
    });
    _values = colorTextCounts;
    return colorTextCounts;
  }

  Map<String, double> _values2 = {};
  Map<String, double> get values2 => _values2;
  Map<String, double> getColorTextCounts2(Map<String, Color> nodeColorMap, Map<Color, String> colorText) {
    // 원하는 순서대로 요소를 추가하기 위해 LinkedHashMap을 사용합니다.
    Map<String, double> colorTextCounts = LinkedHashMap<String, double>();

    // 순서대로 요소를 추가합니다.
    colorText.forEach((color, text) {
      double count = nodeColorMap.values.where((c) => c == color).length.toDouble();
      colorTextCounts[text] = count;
    });
    _values2 = colorTextCounts;
    return colorTextCounts;
  }

  // 마지막 데이터의 수치에 따른 색상
//   String convertToColor(List<Map<String, String>> sensorData, List<Map<String, dynamic>>fileData, BuildContext context) {
//     switch () {
//       case '온도':
//         return 'Temperature (°C)';
//       case '습도':
//         return 'Humidity (%)';
//       case 'TVOC':
//         return 'TVOC (ppb)';
//       case 'CO':
//         return 'CO (ppm)';
//       case 'CO2':
//         return 'CO2 (ppm)';
//       case 'PM10':
//         return 'PM10 (㎍/m³)';
//       case 'PM2.5':
//         return 'PM2.5 (㎍/m³)';
//       default:
//         return name;
//     }
//   }
}