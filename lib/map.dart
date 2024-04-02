import 'package:flutter/material.dart';
import 'package:prio_web/map-units/map-bottom.dart';
import 'package:prio_web/map-units/map-top.dart';

import 'main-units/main-top.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child:  Column(
                    children: [
                      MapTop(),
                      MapBottom(),
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

