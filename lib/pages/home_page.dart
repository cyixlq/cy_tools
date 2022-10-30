
import 'package:cy_tools/component/main_menu_item.dart';
import 'package:cy_tools/common/config.dart';
import 'package:cy_tools/entity/main_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: windowsBg,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CY工具箱'),
        ),
        body: GridView.count(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          physics: const BouncingScrollPhysics(),
          crossAxisCount: _getCrossAxisCount(context),
          children: _createItems(),
        ),
      ),
    );
  }

  List<Widget> _createItems() {
    return mainMenu.map((MainMenu item) =>
      MainMenuItem(menu: item)
    ).toList();
  }

  int _getCrossAxisCount(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final int count;
    final ratio = size.width / size.height;
    if (ratio >= 1.5) {
      count = 8;
    } else if (ratio >= 1.3) {
      count = 7;
    } else if (ratio >= 1) {
      count = 5;
    } else if (ratio >= 0.8) {
      count = 4;
    } else {
      count = 3;
    }
    return count;
  }

}