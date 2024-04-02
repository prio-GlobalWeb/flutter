import 'package:flutter/material.dart';
import 'package:prio_web/services/api.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:prio_web/widgets/buttons.dart';
import 'package:prio_web/widgets/gridview.dart';
import 'package:prio_web/widgets/txt/main-txt.dart';
import 'package:provider/provider.dart';

import '../widgets/dropdown.dart';

class MainRight extends StatefulWidget {
  const MainRight({super.key});

  @override
  State<MainRight> createState() => _MainRightState();
}

class _MainRightState extends State<MainRight> {

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Expanded(
      flex: 8,
      child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  color: Colors.white,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width:170,margin: EdgeInsets.only(left: 15), child: locationDrop(context,),),
                      Container(width:170,margin: EdgeInsets.only(left: 15), child: statusDrop(context,),),
                      Container(width:85, height: double.infinity, margin: EdgeInsets.only(left: 15), child: mapBtn(context),),
                      Container(width:85, height: double.infinity, margin: EdgeInsets.only(left: 15), child: csvBtn(),),
                      Container(width:97, height: double.infinity, margin: EdgeInsets.only(left: 15), child: recordBtn(),),
                      GestureDetector(
                        onTap: (){
                          Provider.of<StateProvider>(context, listen: false).checkClick();
                        },
                        child: Container(
                          width:85,
                          height: double.infinity,
                            margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Provider.of<StateProvider>(context, listen: false).isClick?Color(0xff78b4f0) : Color(0xffaab1b7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.ssid_chart,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(width:95, height: double.infinity, margin: EdgeInsets.only(left: 15), child: graphBtn(context),),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){Provider.of<StateProvider>(context, listen: false).getCurrent(); getData(context);},
                      child: Icon(Icons.refresh, size: 25,),
                    ),
                    const SizedBox(width: 10,),
                    time_txt('${Provider.of<StateProvider>(context,).current}'),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    device_count_txt('PRIO ${dataProvider.prioLen} Devices'),
                    const SizedBox(width: 10,),
                    Expanded(child: Container(height: 1, color: const Color(0xffaab1b7),),),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child:prioGrid(),
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    device_count_txt('WAMONS ${dataProvider.wamonsLen} Devices'),
                    const SizedBox(width: 10,),
                    Expanded(child: Container(height: 1, color: const Color(0xffaab1b7),),),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child:wamonsGrid(),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
