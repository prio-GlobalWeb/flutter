import 'package:flutter/material.dart';
import 'package:prio_web/home.dart';
import 'package:prio_web/widgets/txt/main-txt.dart';
import 'package:provider/provider.dart';

import '../services/providers/dataprovider.dart';
import '../services/providers/mapprovider.dart';
import '../services/providers/provider.dart';

class MainTop extends StatefulWidget {
  const MainTop({super.key});

  @override
  State<MainTop> createState() => _MainTopState();
}

class _MainTopState extends State<MainTop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Provider를 사용하여 MapProvider에 접근
            final mapprovider = Provider.of<MapProvider>(context, listen: false);
            // 상태 초기화 메소드 호출
            mapprovider.resetSelection();

            // Home 페이지로 이동
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return Home(); // 이동할 페이지 위젯
                },
                transitionDuration: Duration(milliseconds: 0), // 전환 시간 설정 (0으로 설정하여 효과를 없앰)
              ),
            );
          },
          child: Image.asset('assets/images/prio.png', fit: BoxFit.contain,),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.language, color: Color(0xffaeafb0), size: 25,),
              SizedBox(width: 10,),
              lang_txt('English'),
              SizedBox(width: 20,),
              Row(
                children: [
                  IconButton(
                    onPressed: (){debugPrint("아이콘 버튼 클릭");},
                    icon: Icon(Icons.note_alt_outlined, size: 25,),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: username_txt('username'),
                  ),
                  IconButton(
                    onPressed: (){debugPrint("종료 버튼 클릭");},
                    icon: Icon(Icons.power_settings_new, size: 25,color: Colors.red,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
