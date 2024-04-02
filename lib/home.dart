import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prio_web/main-units/main-left.dart';
import 'package:prio_web/main-units/main-right.dart';
import 'package:prio_web/main-units/main-top.dart';
import 'package:prio_web/model/data.dart';
import 'package:prio_web/services/api.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:prio_web/widgets/txt/main-txt.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  bool _isLoading = true; // API 호출 상태를 나타내는 변수

  @override
  void initState(){
    super.initState();
    initializedData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initializedData() async{
    await Future.wait([
    getNode(context),
    getCount(context),
    getData(context),
    getSensor(context),
    ]);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 30,),
            loadingtxt(),
          ],
        ),
      )
          : Container(
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
