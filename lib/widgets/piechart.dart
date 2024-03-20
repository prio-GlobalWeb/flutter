import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

List<Color> colorList = [Color(0xff3cbc5b), Color(0xffee8b60), Color(0xffff5963)];

Map<String, double> p_dataMap = {
  "Good": 11,
  "Normal": 1,
  "Bad": 1,
};

Map<String, double> w_dataMap = {
  "Good": 2,
  "Normal": 1,
  "Bad": 0,
};

double sumValues(Map<String, double> data){
  double totalValue = 0;
  data.values.forEach((value) {
    totalValue += value;
  });
  return totalValue;
}

PieChart prioPie(){
  return PieChart(
    dataMap: p_dataMap,
    colorList: colorList,
    centerText: '${sumValues(p_dataMap)}',
    centerTextStyle: TextStyle(
      fontFamily: 'shsM',
      fontSize: 14,
    ),
    chartType: ChartType.ring,
    animationDuration: Duration(seconds: 0),
    legendOptions: LegendOptions(
      legendPosition: LegendPosition.bottom,
      showLegendsInRow: true,
      showLegends: false,
      legendTextStyle: TextStyle(
        fontFamily: 'shsM',
        fontSize: 11,
      ),
    ),
    chartValuesOptions: ChartValuesOptions(
      showChartValueBackground: false,
      showChartValues: false,
      showChartValuesInPercentage: false,
      showChartValuesOutside: false,
      decimalPlaces: 0,
    ),
  );
}

ListView prioCount(){
  return ListView.builder(
    shrinkWrap: true,
    itemCount: p_dataMap.length,
    itemBuilder: (BuildContext context, int idx){
      final List<double> values = p_dataMap.values.toList();
      final value = values[idx];
      return Row(
        children: [
          Icon(Icons.circle, color: colorList[idx],),
          SizedBox(width: 5,),
          Text('${value}'),
        ],
      );
    },
  );
}


PieChart wamonsPie(){
  return PieChart(
    dataMap: w_dataMap,
    colorList: colorList,
    centerText: '${sumValues(w_dataMap)}',
    centerTextStyle: TextStyle(
      fontFamily: 'shsM',
      fontSize: 14,
    ),
    chartType: ChartType.ring,
    animationDuration: Duration(seconds: 0),
    legendOptions: LegendOptions(
      legendPosition: LegendPosition.bottom,
      showLegendsInRow: true,
      showLegends: false,
      legendTextStyle: TextStyle(
        fontFamily: 'shsM',
        fontSize: 11,
      ),
    ),
    chartValuesOptions: ChartValuesOptions(
      showChartValueBackground: false,
      showChartValues: false,
      showChartValuesInPercentage: false,
      showChartValuesOutside: false,
      decimalPlaces: 0,
    ),
  );
}

ListView wamonsCount(){
  return ListView.builder(
    shrinkWrap: true,
    itemCount: w_dataMap.length,
    itemBuilder: (BuildContext context, int idx){
      final List<double> values = w_dataMap.values.toList();
      final value = values[idx];
      return Row(
        children: [
          Icon(Icons.circle,color: colorList[idx]),
          SizedBox(width: 5,),
          Text('${value}'),
        ],
      );
    },
  );
}