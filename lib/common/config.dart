
import 'package:cy_tools/entity/main_menu.dart';
import 'package:flutter/material.dart';

List<MainMenu> mainMenu = [
  MainMenu('幸运大转盘', '转盘.webp', Pages.turnTable),
];

class Pages {
  static const home = '/';
  static const turnTable = '/turn_table';
  static const turnTableSetting = '/turn_table_setting';
}

final BoxDecoration windowsBg = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.1, 1],
        colors: getWindowBgColors()
    )
);

List<Color> getWindowBgColors() {
  final hour = DateTime.now().hour;
  if (hour >= 7 && hour <= 11) {
    return morningColors;
  }
  if (hour >= 12 && hour <= 18) {
    return middleColors;
  }
  return nightColors;
}

const List<Color> morningColors = [
  Color(0xffABDCFF),
  Color(0xff0396FF)
];

const List<Color> middleColors = [
  Color(0xffFCCF31),
  Color(0xffF55555)
];

const List<Color> nightColors = [
  Color(0xff3B2667),
  Color(0xffBC78EC)
];