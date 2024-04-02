import 'package:flutter/material.dart';
import 'package:prio_web/widgets/txt/main-txt.dart';

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
        Image.asset('assets/images/prio.png', fit: BoxFit.contain,),
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
