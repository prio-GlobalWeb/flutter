import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/dataprovider.dart';
import '../services/providers/provider.dart';
import 'main-txt.dart';

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
               if(stateProvider.isClick){
                // isClick 활성화 시 그래프로 확인할 패널 중복 선택 가능하도록
              }else{
                if(stateProvider.selectedPanel != -1){
                  stateProvider.selectedPanel_f();
                }
                stateProvider.updatedPanel(idx);
                if(stateProvider.selectedPanel2 != -1){
                  stateProvider.unselectedPanel2();
                }
              }

              // stateProvider.tempData('Innotems Lab' + '${idx+1}', '${-(idx - 777777)}');
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
                      Icon(Icons.light_mode, size: 35,color: (idx % 2 ==0) ?  Color(0xff4fec76): Color(0xffee8b60)),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  prio_ins_txt('Innotems Lab' + '${idx+1}'),
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
              debugPrint("패널 클릭");
              if(stateProvider.selectedPanel2 != -1){
                stateProvider.selectedPanel2_f();
              }
              stateProvider.updatedPanel2(idx);
              if(stateProvider.selectedPanel != -1){
                stateProvider.unselectedPanel();
              }
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
                      Icon(Icons.light_mode, size: 35, color: (idx % 2 ==0) ?  Color(0xff4fec76): Color(0xffee8b60),),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  wamons_ins_txt('Innotems Lab'+ '${idx+1}'),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}