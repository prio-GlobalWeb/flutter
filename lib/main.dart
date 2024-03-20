import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prio_web/services/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setPathUrlStrategy();
  runApp(ChangeNotifierProvider(
    create: (_) => StateProvider(),
    child: const MyApp(),
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top,SystemUiOverlay.bottom]);
    return ScreenUtilInit(
      // designSize: const Size(360, 690),
      minTextAdapt: true, // 너비와 높이의 최소 값에 따라 텍스트 조정 할지
      splitScreenMode: true, // 분할 화면 지원
      builder: (BuildContext context, child) => MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
          Locale("en",'US'),
        ],
        debugShowCheckedModeBanner: false,
        title: "PRIO WEB",
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: widget!,
          );
        },
        home: Home(),
      ),
    );
  }
}