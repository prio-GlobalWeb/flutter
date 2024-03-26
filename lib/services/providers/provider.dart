import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:prio_web/services/providers/dataprovider.dart';

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
    if(value == "Good"){
      _coloridx = 1;
      _color = Color(0xff4fec76);
    }
    if(value == "Normal") {
      _coloridx = 2;
      _color = Color(0xffee8b60);
    }
    if(value == "Bad"){
      _coloridx = 3;
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

  void resetPanel(idx){
    _count = 0;
    notifyListeners();
  }

  void selectedPanel_f(){
    _panelClicks[_selectedPanel] = false;
    notifyListeners();
  }
  void unselectedPanel2(){
    _panelClicks2[_selectedPanel2] = false;
    notifyListeners();
  }
  void updatedPanel(int idx){
    if (_selectedPanel == idx) {
      _count++; // 패널을 누를 때마다 count 증가
      print(count);
    } else {
      _count = 1; // 새로운 패널을 눌렀을 때는 count 초기화
      print(count);
    }
    _selectedPanel = idx;
    _panelClicks[idx] = !panelClicks[idx];
    print(selectedPanel);
    print(panelClicks);
    notifyListeners();
  }

  void selectedPanel2_f(){
    _panelClicks2[_selectedPanel2] = false;
    notifyListeners();
  }
  void unselectedPanel(){
    _panelClicks[_selectedPanel] = false;
    notifyListeners();
  }
  void updatedPanel2(int idx){
    if (_selectedPanel2 == idx) {
      _count++; // 패널을 누를 때마다 count 증가
    } else {
      _count = 1; // 새로운 패널을 눌렀을 때는 count 초기화
    }
    _selectedPanel2 = idx;
    _panelClicks2[idx] = !panelClicks2[idx];
    print(selectedPanel2);
    print('{panelClicks2}');
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

}