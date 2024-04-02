import 'package:flutter/material.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:prio_web/widgets/txt/main-txt.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prio_web/widgets/piechart.dart';
import 'package:provider/provider.dart';
import '../services/providers/dataprovider.dart';

class MainLeft extends StatefulWidget {
  const MainLeft({super.key});

  @override
  State<MainLeft> createState() => _MainLeftState();
}

class _MainLeftState extends State<MainLeft> {

  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<StateProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (dataProvider.node == null ||(stateProvider.prioClick==false && stateProvider.wamonsClick==false)) ?
          Container(
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xff3994ef)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: data_txt('Select Device Panel'),
            ),
          ) : dataProvider.nodeData ==null ?
          Container(
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xff3994ef)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  data_txt('No Data\n'),
                  data_txt2('Check the connection status of the product'),
                  data_txt2('Check the network status'),
                ],
              )
            ),
          ) :
          Container(
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
                      ins_name('${dataProvider.location}'),
                      nodeid('${dataProvider.node}'),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xffaab1b7),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        width: 75,
                        // width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: stateProvider.statusColor(dataProvider.sum),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: prio_status('${dataProvider.sum}'),
                        // child: prio_status('${stateProvider.getNodeColorMap(dataProvider.nodeSums, 'PRIO',context)}'),
                    ),
                    Text('${stateProvider.colorText[stateProvider.statusColor(dataProvider.sum)]}', style: status_textStyle(),),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataProvider.returnCnt(dataProvider.node!),
                  itemBuilder: (BuildContext context, int idx){
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle, size: 24,),
                                    SizedBox(width: 10,),
                                    type_txt(dataProvider.returnName(dataProvider.node), idx,),
                                  ],
                                ),
                                Text('${dataProvider.fileData[idx]['file_data']}'),
                              ],
                            ),
                            dataProvider.returnTarget(dataProvider.node).isNotEmpty ?
                            target_txt(dataProvider.returnTarget(dataProvider.node), idx,) : Container(),
                          ],
                        )
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
                stateProvider.wamonsClick ?Container(width: 0,height: 0,) : Container(
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
                            prioCount(context),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: prioPie(context),
                      ),
                    ],
                  ),
                ),
                dataProvider.node != null ? Container(width: 0,height: 0,) : Divider(
                  thickness: 1,
                  color: Color(0xffaab1b7),
                ),
                stateProvider.prioClick ?Container(width: 0,height: 0,) : Container(
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
                            wamonsCount(context),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: wamonsPie(context),
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
