import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../services/providers/dataprovider.dart';

void calScore(Map<String, List<double>> dataMap, BuildContext context, String node){
  Provider.of<DataProvider>(context, listen: false).resetSum();
  dataMap.forEach((key, value){
    switch(int.parse(key)){
      case 5:
        calTemp(key, value, context, node);
        break;
      case 6:
        calHumidity(key, value, context, node);
        break;
      case 7:
        calTVOC(key, value, context, node);
        break;
        case 8:
        calCO(key, value, context, node);
        break;
      case 9:
        calCO2(key, value, context, node);
        break;
      case 11:
        calPM10(key, value, context, node);
        break;
      case 13:
        calPM25(key, value, context, node);
        break;
    }
  });
}

DateTime now = DateTime.now();
int month = now.month;

thScore(String key,double avg, BuildContext context, String node){
  if(avg <= 2){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 10, node);
  }
  else if(avg <= 4){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 8, node);
  }
  else if(avg <= 6){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 6, node);
  }
  else if(avg <= 8){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 4, node);
  }
  else{
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 2, node);
  }
}

void calTemp(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  if(month ==3 || month == 4 || month==5){
    values.forEach((v) => sum+=(v-22));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
  else if(month ==6 || month == 7 || month==8){
    values.forEach((v) => sum+=(v-26));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
  else if(month ==9 || month == 10 || month==11){
    values.forEach((v) => sum+=(v-22));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
  else{
    values.forEach((v) => sum+=(v-20));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
}

void calHumidity(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  if(month ==3 || month == 4 || month==5){
    values.forEach((v) => sum+=(v-50));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
  else if(month ==6 || month == 7 || month==8){
    values.forEach((v) => sum+=(v-60));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
  else if(month ==9 || month == 10 || month==11){
    values.forEach((v) => sum+=(v-50));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
  else{
    values.forEach((v) => sum+=(v-40));
    var avg = double.parse((sum/cnt).toStringAsFixed(2));
    thScore(key, avg, context, node);
  }
}



calTVOC(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  values.forEach((v) => sum+=v);
  double avg = sum/cnt;
  if(avg <= 1000){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 10, node);
  }
  else if(avg <= 2000){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 8, node);
  }
  else if(avg <= 3000){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 6, node);
  }
  else if(avg <= 4000){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 4, node);
  }
  else{
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 2, node);
  }
}

void calCO(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  values.forEach((v) => sum+=v);
  double avg = sum/cnt;
  if(avg <= 5){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 10, node);
  }
  else if(avg <= 10){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 8, node);
  }
  else if(avg <= 25){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 6, node);
  }
  else if(avg <= 100){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 4, node);
  }
  else{
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 2, node);
  }
}

void calCO2(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  values.forEach((v) => sum+=v);
  double avg = sum/cnt;
  if(avg <= 20){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 20, node);
  }
  else if(avg >= 451 && avg <= 700){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 16, node);
  }
  else if(avg >= 701 && avg <= 1000){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 12, node);
  }
  else if(avg >= 1001 && avg <= 2999){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 8, node);
  }
  else{
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 4, node);
  }
}

void calPM10(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  values.forEach((v) => sum+=v);
  double avg = sum/cnt;
  if(avg <= 20){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 20, node);
  }
  else if(avg >= 21 && avg <= 79){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 16, node);
  }
  else if(avg >= 80 && avg <= 119){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 12, node);
  }
  else if(avg >= 120 && avg <= 240){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 8, node);
  }
  else{
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 4, node);
  }
}

void calPM25(String key, List<double> values, BuildContext context, node){
  double sum = 0;
  int cnt = values.length;
  values.forEach((v) => sum+=v);
  double avg = sum/cnt;
  if(avg <= 10){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 20, node);
  }
  else if(avg >= 11 && avg <= 35){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 16, node);
  }
  else if(avg >= 36 && avg <= 50){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 12, node);
  }
  else if(avg >= 51 && avg <= 79){
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 8, node);
  }
  else{
    Provider.of<DataProvider>(context, listen: false).saveScores(key, 4, node);
  }
}
