import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:provider/provider.dart';

PieChart prioPie(BuildContext context){
  final stateProvider = Provider.of<StateProvider>(context);
  final dataProvider = Provider.of<DataProvider>(context);
  List<Color> colorList = stateProvider.colorText.keys.toList();
  Map<String, double> result = stateProvider.getColorTextCounts(
      stateProvider.getNodeColorMap(dataProvider.nodeSums, "PRIO", context),
      stateProvider.colorText
  );
  return PieChart(
    dataMap: result,
    colorList: colorList,
    centerText: '${Provider.of<DataProvider>(context,listen: false).prioLen}',
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

ListView prioCount(context){
  final stateProvider = Provider.of<StateProvider>(context);
  return ListView.builder(
    shrinkWrap: true,
    itemCount: stateProvider.colorText.length,
    itemBuilder: (BuildContext context, int idx){
      final List<double> values = stateProvider.values.values.toList();
      final value = values[idx];
      return Row(
        children: [
          Icon(Icons.circle, color: stateProvider.colorText.keys.toList()[idx],),
          SizedBox(width: 5,),
          value!=null?Text('${value}'):Text('0'),
        ],
      );
    },
  );
}


PieChart wamonsPie(BuildContext context){
  final stateProvider = Provider.of<StateProvider>(context);
  final dataProvider = Provider.of<DataProvider>(context);
  List<Color> colorList = stateProvider.colorText.keys.toList();
  Map<String, double> result = stateProvider.getColorTextCounts2(stateProvider.getNodeColorMap(dataProvider.nodeSums, "WAMONS", context), stateProvider.colorText);
  return PieChart(
    dataMap: result,
    colorList: colorList,
    centerText: '${Provider.of<DataProvider>(context,listen: false).wamonsLen}',
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

ListView wamonsCount(BuildContext context){
  final stateProvider = Provider.of<StateProvider>(context);
  return ListView.builder(
    shrinkWrap: true,
    itemCount: stateProvider.colorText.length,
    itemBuilder: (BuildContext context, int idx){
      final List<double> values = stateProvider.values2.values.toList();
      final value = values[idx];
      return Row(
        children: [
          Icon(Icons.circle,color: stateProvider.colorText.keys.toList()[idx]),
          SizedBox(width: 5,),
          value!=null?Text('${value}'):Text('0'),
        ],
      );
    },
  );
}