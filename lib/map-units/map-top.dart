import 'package:flutter/material.dart';
import 'package:prio_web/services/providers/mapprovider.dart';
import 'package:prio_web/widgets/buttons.dart';
import 'package:prio_web/widgets/txt/map-txt.dart';
import 'package:provider/provider.dart';

import '../services/providers/provider.dart';

class MapTop extends StatefulWidget {
  const MapTop({super.key});

  @override
  State<MapTop> createState() => _MapTopState();
}

class _MapTopState extends State<MapTop> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, mapprovider,_){
        final stateprovider = Provider.of<StateProvider>(context);
        final mapprovider = Provider.of<MapProvider>(context);
        return Container(
            height: MediaQuery.of(context).size.height/7.5,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffaab1b7)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: Container(
                          // color: Colors.black12,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(), // 스크롤 금지
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2,
                            ),
                            itemCount: mapprovider.sensorNamesList.length,
                            itemBuilder: (context, idx){
                              return GestureDetector(
                                onTap: () {
                                  if(mapprovider.editClick == false){
                                    mapprovider.onoffSensor(idx);
                                    mapprovider.tmpName(mapprovider.sensorNamesList[idx]);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: mapprovider.sensorClicks[idx] == true? BoxDecoration(
                                    color: Color(0xff78b4f0),
                                  ):
                                  BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: sensorText(
                                    '${mapprovider.sensorNamesList[idx]}',
                                    mapprovider.sensorClicks[idx] == true? Colors.white : Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    )
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 40, 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // edit 버튼을 클릭 했을 때 save 버튼 나타남
                            // edit 버튼 활성화 시 회색
                            mapprovider.editClick ?
                            Container(
                              width: 100,
                              height: 50,
                              child: saveBtn(context),
                            ) : Container(),
                            // mapprovider.editClick ?
                            // SizedBox(width: 30,) : SizedBox(width: 0,),
                            // mapprovider.editClick ?
                            // Container(
                            //   width: 120,
                            //   height: 50,
                            //   child: registerBtn(context),
                            // ) : Container(),
                            mapprovider.editClick ?
                            SizedBox(width: 30,) : SizedBox(width: 0,),
                            Container(
                              width: 100,
                              height: 50,
                              child: editBtn(context),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}
