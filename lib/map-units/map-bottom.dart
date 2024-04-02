import 'package:flutter/material.dart';

class MapBottom extends StatefulWidget {
  const MapBottom({super.key});

  @override
  State<MapBottom> createState() => _MapBottomState();
}

class _MapBottomState extends State<MapBottom> {
  Color _pointColor = Colors.blue; // 초기 지점 색상

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 30),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            // 사용자가 화면을 클릭할 때 지점의 색상을 변경하고 좌표를 출력
            print('User tapped at: ${details.globalPosition}');
            setState(() {
              _pointColor = Colors.red;
            });
          },
          onTapUp: (TapUpDetails details) {
            // 사용자가 클릭을 멈출 때 다시 원래 색상으로 변경
            setState(() {
              _pointColor = Colors.blue;
            });
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blueGrey,
            child: CustomPaint(
              painter: PointPainter(_pointColor),
            ),
          ),
        ),
      ),
    );
  }
}

class PointPainter extends CustomPainter {
  final Color color;

  PointPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // 사용자가 클릭하는 지점에 원을 그립니다.
    Paint paint = Paint()..color = color;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
