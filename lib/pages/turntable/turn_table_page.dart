
import 'dart:math';

import 'package:cy_tools/common/config.dart';
import 'package:cy_tools/component/pointer.dart';
import 'package:cy_tools/component/turn_table.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TurnTablePage extends StatefulWidget {

  const TurnTablePage({super.key});

  @override
  State<TurnTablePage> createState() => _TurnTableState();
}

class _TurnTableState extends State<TurnTablePage> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Tween<double> _tween;
  late CurvedAnimation _curve;
  final Random _random = Random();
  final List<String> _gifts = [];
  bool isStart = false;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _tween = Tween<double>(begin: 0.0, end: 10.0);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isStart = false;
      }
    });
    super.initState();
    _getGifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: const Text('幸运大转盘'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                .pushNamed(Pages.turnTableSetting)
                .then((result) {
                  if (result != null && result is List<String>) {
                    _gifts.clear();
                    setState(() {
                      _gifts.addAll(result);
                    });
                  }
                });
            },
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          children: [
            RotationTransition(
              turns: _tween.animate(_curve),
              child: TurnTable(gifts: _gifts),
            ),
            const Pointer(),
            LayoutBuilder(builder: (context, cons) {
              final radius = min(cons.maxWidth / 2, cons.maxHeight / 2) / 6;
              return Center(
                child: InkWell(
                  onTap: () {
                    if (isStart) {
                      return;
                    }
                    isStart = true;
                    _tween.end = 10 + _random.nextDouble() * 20;
                    _controller.reset();
                    _controller.forward();
                  },
                  child: SizedBox(
                    width: radius,
                    height: radius,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _curve.dispose();
    super.dispose();
  }

  void _getGifts() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('gifts') ?? [];
    _gifts.clear();
    setState(() {
      _gifts.addAll(list);
    });
  }
}