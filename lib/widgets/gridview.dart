import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/dataprovider.dart';
import '../services/providers/provider.dart';
import 'txt/main-txt.dart';

Widget prioGrid(){
  return Consumer<StateProvider>(
    builder: (context, stateProvider, _){
      final stateProvider = Provider.of<StateProvider>(context, listen: false);
      final dataProvider = Provider.of<DataProvider>(context);
      final prioData = dataProvider.panelData.where((data) => data['category'] == "PRIO").toList();
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 2.3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 50,
        ),
        itemCount: dataProvider.panelData.where((data) => data['category'] == "PRIO").length,
        itemBuilder: (BuildContext context, int idx){
          return GestureDetector(
            onTap: (){
              if (stateProvider.selectedPanel != -1) {
                stateProvider.selectedPanel_f();
              }
              stateProvider.updatedPanel(idx);
              if (stateProvider.selectedPanel2 != -1 && stateProvider.count != 2) {
                stateProvider.unselectedPanel2();
              }
              if (stateProvider.count == 2) {
                stateProvider.resetPanel(idx);// count가 2일 때는 count 초기화
                stateProvider.click(3);
                stateProvider.selectedPanel_f();
                dataProvider.resetData();
              }
              if(stateProvider.count==1){
                stateProvider.click(1);
              }
              dataProvider.setData(prioData[idx]['setup_location'], prioData[idx]['id']);
              dataProvider.returnData_node(dataProvider.node, context);
            },
            child: Container(
              padding: stateProvider.panelClicks[idx]
                  ? EdgeInsets.fromLTRB(8,8,8, 0) : EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: stateProvider.panelClicks[idx]
                    ? Border.all(color: const Color(0xff3994ef), width: 3) : Border.all(color: const Color(0xff3994ef)),
                color: stateProvider.isClick ? Color(0x303994ef): Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      prio_txt('${prioData[idx]['id']}'),
                      dataProvider.nodeSums[prioData[idx]['id']] == null ?  Icon(Icons.light_mode, size: 35,color: Colors.grey):
                      Icon(Icons.light_mode, size: 35,color: stateProvider.statusColor(dataProvider.nodeSums[prioData[idx]['id']]!)),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  prio_ins_txt('${prioData[idx]['setup_location']}'),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget wamonsGrid(){
  return Consumer<StateProvider>(
    builder: (context, stateProvider, _){
      final stateProvider = Provider.of<StateProvider>(context, listen: false);
      final dataProvider = Provider.of<DataProvider>(context);
      final wamonsData = dataProvider.panelData.where((data) => data['category'] == "WAMONS").toList();
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 2.3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 50,
        ),
        itemCount: dataProvider.panelData.where((data) => data['category'] == "WAMONS").length,
        itemBuilder: (BuildContext context, int idx){
          return GestureDetector(
            onTap: (){
              if (stateProvider.selectedPanel2 != -1) {
                stateProvider.selectedPanel2_f();
              }
              stateProvider.updatedPanel2(idx);
              if (stateProvider.selectedPanel != -1 && stateProvider.count != 2) {
                stateProvider.unselectedPanel();
              }
              if (stateProvider.count == 2) {
                stateProvider.resetPanel(idx); // count가 2일 때는 count 초기화
                stateProvider.click(3);
                stateProvider.selectedPanel2_f();
                dataProvider.resetData();
              }
              if(stateProvider.count==1){
                stateProvider.click(2);
              }
              dataProvider.setData(wamonsData[idx]['setup_location'], wamonsData[idx]['id']);
              dataProvider.returnData_node(dataProvider.node, context);
            },
            child: Container(
              padding: stateProvider.panelClicks2[idx]
                  ? EdgeInsets.fromLTRB(8,8,8, 0) : EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: stateProvider.panelClicks2[idx]
                    ? Border.all(color: const Color(0xff3994ef), width: 3) : Border.all(color: const Color(0xff3994ef),),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      wamons_txt('${wamonsData[idx]['id']}'),
                      dataProvider.nodeSums[wamonsData[idx]['id']] == null
                          ?  Icon(Icons.light_mode, size: 35,color: Colors.grey):
                      Icon(Icons.light_mode, size: 35,color: stateProvider.statusColor(dataProvider.nodeSums[wamonsData[idx]['id']]!)),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  wamons_ins_txt('${wamonsData[idx]['setup_location']}'),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}