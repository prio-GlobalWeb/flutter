import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prio_web/main-units/main-left.dart';
import 'package:prio_web/main-units/main-right.dart';
import 'package:prio_web/main-units/main-top.dart';
import 'package:prio_web/services/api.dart';
import 'package:prio_web/services/provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  void count(){
    // String str = "5741 4D30 3033 0000 018C 20BF 3CD6 0006 0001 0000 3BA7 0002 0000 0C82 0003 0000 0C0C 0004 0000 BB80 0005 0000 05CE 0006 0000 05EB";
    // String str = "57414D3030330000018C20BF3CD60006000100003BA7000200000C82000300000C0C00040000BB800005000005CE0006000005EB";
    // String str = "57414D3030330000018C20C0245F0006000100003BA8000200000C81000300000C0700040000B9F0000500000520000600000594";
    String str = "5052 4F30 3038 0000 018C 20BF 368A 000D FFFF 0000 048F FFFF 0000 0000 FFFF 0000 0000 0004 0000 7FB6 0005 FFFF FAB8 0006 0000 0878 0007 0000 0000 0008 0000 0000 0009 0000 A2E4 FFFF 0000 03E8 000B 0000 06B6 FFFF 0000 9C40 000D 0000 05EB";
    debugPrint("${str.length}");
  }

  @override
  void initState(){
    super.initState();
    getNodeInfo(context);
    count();
    // getData(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   child: ListView.builder(
      //     itemCount: Provider.of<StateProvider>(context).tempData3.length,
      //     itemBuilder: (context, index) {
      //       var item = Provider.of<StateProvider>(context).tempData3[index];
      //       return ListTile(
      //         title: Text(item['setup_location'] ?? ''), // null 체크 후 공백으로 대체
      //         subtitle: Text(item['id'] ?? ''), // null 체크 후 공백으로 대체
      //       );
      //     },
      //   )
    body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xffaab1b7)),
                        ),
                      ),
                      child:MainTop(),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Container(
                        color: Colors.white,
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainLeft(),
                            MainRight(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


    );
  }
}
