import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prio_web/services/providers/dataprovider.dart';
import 'package:prio_web/services/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setPathUrlStrategy();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StateProvider()),
          ChangeNotifierProvider(create: (_) => DataProvider()),
        ],
        child: const MyApp(),
      ),
  );
  // runApp(
  //   EasyLocalization(
  //     saveLocale: true,
  //     useOnlyLangCode: true,
  //     supportedLocales: [Locale('en'), Locale('ko')],
  //     path: 'assets/translations',
  //     fallbackLocale: Locale('en'),
  //     child: MultiProvider(
  //       providers: [
  //         ChangeNotifierProvider(create: (_) => StateProvider()),
  //         ChangeNotifierProvider(create: (_) => DataProvider()),
  //       ],
  //       child: const MyApp(),
  //     ),
  //   ),
  // );
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
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
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