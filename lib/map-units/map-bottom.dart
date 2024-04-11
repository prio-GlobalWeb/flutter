import 'package:flutter/material.dart';
import 'package:prio_web/services/providers/mapprovider.dart';
import 'package:prio_web/widgets/buttons.dart';
import 'package:prio_web/widgets/dropdown.dart';
import 'package:prio_web/widgets/txt/map-txt.dart';
import 'package:provider/provider.dart';

import '../services/providers/dataprovider.dart';
import '../services/providers/provider.dart';
import '../widgets/txt/main-txt.dart';

class MapBottom extends StatefulWidget {
  const MapBottom({super.key});

  @override
  State<MapBottom> createState() => _MapBottomState();
}

class _MapBottomState extends State<MapBottom> {
  // final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mapprovider = Provider.of<MapProvider>(context);
    final dataprovider = Provider.of<DataProvider>(context);
    final stateprovider = Provider.of<StateProvider>(context);

    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            height: MediaQuery.of(context).size.height/8,
            // color: Colors.yellowAccent,
            child: Container(
              // color: Colors.blueGrey.shade100,
              child: mapprovider.editClick? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text('NodeID : ', style: TextStyle(fontFamily: 'shsM', fontSize: 18,),),
                      Container(width:200, height: 50, margin: const EdgeInsets.only(left: 15), child: nodeDrop(context,),),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Location : ', style: TextStyle(fontFamily: 'shsM', fontSize: 18),),
                      const SizedBox(width: 15,),
                      Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: mapprovider.locationController,
                          decoration: const InputDecoration(
                            border: InputBorder.none, // underline 제거
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          onChanged: (location){
                            mapprovider.setLocation(location);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('X좌표 : ', style: TextStyle(fontFamily: 'shsM', fontSize: 18),),
                      Container(
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                            mapprovider.dx != 0 ? mapprovider.dx.toString() : "",
                            style: const TextStyle(fontFamily: 'shsM', fontSize: 18)
                        ),
                      ),
                      const SizedBox(width: 30,),
                      const Text('Y좌표 : ', style: TextStyle(fontFamily: 'shsM', fontSize: 18),),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            mapprovider.dy != 0 ? mapprovider.dy.toStringAsFixed(1) : "",
                            style: const TextStyle(fontFamily: 'shsM', fontSize: 18)
                        ),
                      ),
                      const SizedBox(width: 30,),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: resetBtn(context, mapprovider.dx, mapprovider.dy),
                      )
                    ],
                  ),
                ],
              ) : Container(),
            ),
          ),
          Expanded(
            flex: 1,
            child:Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child:  Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                color: Colors.blue.shade200,
                child: mapprovider.editClick ?
                Stack(
                  children: [
                    Container(
                      color: Colors.white, // 흰색 배경
                      padding: EdgeInsets.fromLTRB(70, 50, 70, 50),
                      width: double.infinity,
                      height: double.infinity, // 컨테이너가 화면 전체를 채우도록 설정
                      child: Image.asset('assets/images/map.png', width: double.infinity, height: double.infinity, fit: BoxFit.fill,),
                    ),
                    Positioned(
                      top: 50,
                      bottom: 50,
                      left: 70,
                      right: 70,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          // 이미지 영역 내의 좌표를 계산
                          var localPosition = details.localPosition;
                          if(mapprovider.editClick){
                            mapprovider.setPosition(localPosition.dx, localPosition.dy);
                          }
                        },
                        child: Container(
                          color: Colors.transparent, // 투명한 배경
                          child: CustomPaint(
                            painter: mapprovider.dx != 0 && mapprovider.dy != 0
                                ? CirclePainter(Offset(mapprovider.dx, mapprovider.dy)) // 좌표값을 Offset 객체로 변환하여 전달합니다.
                                : null, // 좌표가 (0, 0)인 경우에는 원을 그리지 않습니다.
                          ),
                        ),
                      ),
                    ),
                  ],
                ) : Stack(
                  children: [
                    Container(
                      color: Colors.white, // 흰색 배경
                      padding: EdgeInsets.fromLTRB(70, 50, 70, 50),
                      width: double.infinity,
                      height: double.infinity, // 컨테이너가 화면 전체를 채우도록 설정
                      child: Image.asset('assets/images/map.png',width: double.infinity, height: double.infinity, fit: BoxFit.fill,),
                    ),
                    ...mapprovider.positionData.asMap().entries.map((entry) {
                      int index = entry.key;
                      var position = entry.value;
                      double positionX = double.parse(position['position_x'].toString());
                      double positionY = double.parse(position['position_y'].toString());
                      String nodeID = position['id'];
                      int nodeSum = dataprovider.nodeSums[nodeID] ?? 0;

                      return Stack(
                        children: [
                          Positioned(
                            left:positionX +62.5,
                            top:positionY + 42.5,
                            child: GestureDetector(
                              onTap: (){
                                mapprovider.selectCircle(index);
                                dataprovider.returnData_node(position['id'], context);
                                mapprovider.saveClickNode(position['id']);
                              },
                              child: MouseRegion(
                                onEnter: (_) => mapprovider.setHovered(index, true),
                                onExit: (_) => mapprovider.setHovered(index, false),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: mapprovider.isHovered(index) ? 18 : 15,
                                  height: mapprovider.isHovered(index) ? 18 : 15,
                                  decoration: BoxDecoration(
                                    color: stateprovider.statusColor(nodeSum),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            )
                          ),
                          if (!mapprovider.editClick) // mapprovider.editClick가 false일 때만 말풍선을 렌더링
                            Positioned(
                              left: positionX + 85, // 원에서 약간 오른쪽에 위치
                              top: positionY + 25, // 원에서 약간 위쪽에 위치
                              child: CustomPaint(
                                painter: BalloonPainter(),
                                child: Container(
                                  // 화살표의 높이를 고려한 패딩 조정
                                  padding: const EdgeInsets.fromLTRB(20, 5, 8, 5).copyWith(bottom: 5),
                                  child: Column(
                                    // 컨텐츠 크기에 맞춰 컬럼 크기 조절
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID: ${position['id']}',
                                        style: const TextStyle(fontSize: 14, fontFamily: 'shsR', color: Colors.white),
                                      ),
                                      Text(
                                        'Location: ${position['setup_location']}',
                                        style: const TextStyle(fontSize: 14, fontFamily: 'shsR', color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          // 좌표(원형) 클릭시 좌측에 나타나는 측정 데이터 패널
                          if(mapprovider.selectedCircleIndex !=null)
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Container(
                                width: 350,
                                height:450,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: const Color(0xff3994ef), width: 2),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(0,5,0,5),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          map_insName(mapprovider.getSelectedCircleData()?['setup_location'] ?? 'Unknown Location'),
                                          map_nodeid(mapprovider.getSelectedCircleData()?['id'] ?? 'Unknown ID'),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Color(0xffaab1b7),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(vertical: 10),
                                          alignment: Alignment.center,
                                          width: 75,
                                          // width: 300,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: stateprovider.statusColor(dataprovider.sum),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: prio_status('${dataprovider.sum}'),
                                          // child: prio_status('${stateProvider.getNodeColorMap(dataProvider.nodeSums, 'PRIO',context)}'),
                                        ),
                                        Text('${stateprovider.colorText[stateprovider.statusColor(dataprovider.sum)]}', style: status_textStyle(),),
                                      ],
                                    ),
                                    Flexible(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: dataprovider.returnCnt(mapprovider.clickNode),
                                        itemBuilder: (BuildContext context, int idx){
                                          return Container(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.circle, size: 24,),
                                                          const SizedBox(width: 10,),
                                                          type_txt(dataprovider.returnName(mapprovider.clickNode), idx,),
                                                        ],
                                                      ),
                                                      Text('${dataprovider.fileData[idx]['file_data']}'),
                                                    ],
                                                  ),
                                                  dataprovider.returnTarget(mapprovider.clickNode).isNotEmpty ?
                                                  target_txt(dataprovider.returnTarget(mapprovider.clickNode), idx,) : Container(),
                                                ],
                                              )
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}

class CirclePainter extends CustomPainter {
  final Offset position;
  CirclePainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // 원 색상
      ..strokeWidth = 5 // 선의 너비
      ..style = PaintingStyle.fill; // 원을 채우거나 윤곽선만 그릴지 결정
    // 원 그리기
    canvas.drawCircle(position, 7.5, paint); // 반지름이 10인 원 그리기
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BalloonPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;
  final double arrowWidth;
  final double arrowHeight;
  final double borderWidth;
  final double borderRadius;

  BalloonPainter({
    this.backgroundColor = Colors.lightBlueAccent,
    this.borderColor = Colors.white,
    this.arrowWidth = 10.0,
    this.arrowHeight = 10.0,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    Path balloonPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        // 말풍선 본체: 화살표 너비만큼 오른쪽으로 이동하여 시작.
          Rect.fromLTWH(arrowWidth, 0, size.width - arrowWidth, size.height), Radius.circular(borderRadius)))
    // 화살표를 말풍선의 세로 중앙에 위치시키기
      ..moveTo(arrowWidth, size.height / 2 - arrowHeight / 2) // 화살표 상단 시작점
      ..lineTo(0, size.height / 2) // 화살표 끝점, 말풍선 외부 중앙
      ..lineTo(arrowWidth, size.height / 2 + arrowHeight / 2) // 화살표 하단 끝점
      ..close(); // 경로 닫기

    canvas.drawPath(balloonPath, paint);
    canvas.drawPath(balloonPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}