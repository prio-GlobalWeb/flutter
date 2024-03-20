import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  String? _location;
  String? get location => _location;
  String? _node;
  String? get node => _node;

  List _panelData = [];
  List get panelData => _panelData;

  void tempData(data){
    _panelData = data;
    notifyListeners();
  }

  int? _prioLen;
  int? get prioLen => _prioLen;
  int? _wamonsLen;
  int? get wamonsLen => _wamonsLen;
  void lenSet(prio, wamons){
    _prioLen = prio;
    _wamonsLen = wamons;
    notifyListeners();
  }
}