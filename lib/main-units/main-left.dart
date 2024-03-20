import 'package:flutter/material.dart';
import 'package:prio_web/services/provider.dart';
import 'package:prio_web/widgets/main-txt.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prio_web/widgets/piechart.dart';
import 'package:provider/provider.dart';

class MainLeft extends StatefulWidget {
  const MainLeft({super.key});

  @override
  State<MainLeft> createState() => _MainLeftState();
}

class _MainLeftState extends State<MainLeft> {
  List types = [
    'Temperature (°C)', 'Humidity (%)', 'TVOC (ppb)',
    'CO(ppm)', 'CO2 (ppm)', 'PM10 (㎍/m³)', 'PM2.5 (㎍/m³)'
  ];

  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<StateProvider>(context);
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: Provider.of<StateProvider>(context, listen: false).node == null
            ?MainAxisAlignment.center : MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Provider.of<StateProvider>(context, listen: false).node == null
              ?Container(width: 0,height: 0,) : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xff3994ef)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0,5,0,5),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ins_name('${stateProvider.location}'),
                      nodeid('${stateProvider.node}'),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xffaab1b7),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  width: 74,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff4fec76),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: prio_status('Good'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int idx){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle, size: 24,),
                              SizedBox(width: 10,),
                              type_txt(types, idx,)
                            ],
                          ),
                          Text('${idx + 999}'),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xff3994ef)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: chart_txt('Total Status'),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xffaab1b7),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: pietitle_txt('PRIO'),
                            ),
                            SizedBox(height: 5,),
                            prioCount(),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: prioPie(),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xffaab1b7),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: pietitle_txt('WAMONS'),
                            ),
                            SizedBox(height: 5,),
                            wamonsCount(),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: wamonsPie(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
