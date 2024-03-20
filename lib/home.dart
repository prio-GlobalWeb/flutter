import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prio_web/main-units/main-left.dart';
import 'package:prio_web/main-units/main-right.dart';
import 'package:prio_web/main-units/main-top.dart';
import 'package:prio_web/services/api.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
    getNode(context);
    getCount(context);
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
