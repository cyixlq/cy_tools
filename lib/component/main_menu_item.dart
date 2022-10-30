
import 'package:cy_tools/entity/main_menu.dart';
import 'package:flutter/material.dart';

class MainMenuItem extends StatelessWidget {

  final MainMenu menu;

  const MainMenuItem({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(menu.path)
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Image.asset(
                menu.img,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            menu.title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

}