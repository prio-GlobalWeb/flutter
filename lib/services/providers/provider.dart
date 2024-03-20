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

  void selectedPanel_f(){
    _panelClicks[_selectedPanel] = false;
    notifyListeners();
  }
  void unselectedPanel2(){
    _panelClicks2[_selectedPanel2] = false;
    notifyListeners();
  }
  void updatedPanel(int idx){
    _selectedPanel = idx;
    _panelClicks[idx] = !panelClicks[idx];
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
}