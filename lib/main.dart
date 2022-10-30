import 'dart:js';

import 'package:cy_tools/common/config.dart';
import 'package:cy_tools/pages/home_page.dart';
import 'package:cy_tools/pages/turntable/turn_table_page.dart';
import 'package:cy_tools/pages/turntable/turn_table_setting_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CY工具箱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        scaffoldBackgroundColor: Colors.transparent
      ),
      routes: _routes,
    );
  }
}

Map<String, WidgetBuilder> _routes = {
  Pages.home : (context) => const HomePage(),
  Pages.turnTable : (context) => const TurnTablePage(),
  Pages.turnTableSetting : (context) => const TurnTableSettingPage()
};