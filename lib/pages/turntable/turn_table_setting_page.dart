
import 'package:cy_tools/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TurnTableSettingPage extends StatefulWidget {

  const TurnTableSettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _TurnTableSettingPageState();
  
}

class _TurnTableSettingPageState extends State<TurnTableSettingPage> {

  final List<String> _gifts = [];
  final TextEditingController _giftController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getGifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: const Text('大转盘设置'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done), 
            onPressed: () => _saveGifts(),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: TextField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _giftController,
                  style: const TextStyle(color: Colors.white,),
                  decoration: const InputDecoration(
                    labelText: '礼物名',
                    hintText: '请在此处输入礼物名，例如：iPhone 14 Pro Max',
                    prefixIcon: Icon(Icons.card_giftcard, color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                    ),
                    focusColor: Colors.blue
                  ),
                ),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () => _insertGift(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  height: 60,
                  child: const Text(
                    '添加',
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _gifts[index],
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () => _deleteGift(index),
                      icon: const Icon(Icons.delete, color: Colors.white)
                  ),

                );
              },
              itemCount: _gifts.length
            )
          )
        ],
      ),
    );
  }

  void _getGifts() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('gifts') ?? [];
    _gifts.clear();
    setState(() {
      _gifts.addAll(list);
    });
  }

  void _deleteGift(int index) {
    setState(() {
      _gifts.removeAt(index);
    });
  }

  void _insertGift() {
    final gift = _giftController.text;
    if (gift.trim().isEmpty) {
      showToast(context, '请输入礼物名');
      return;
    }
    setState(() {
      _giftController.clear();
      _gifts.insert(0, gift);
    });
  }

  void _saveGifts() async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList('gifts', _gifts).then((isSuccess) {
      if (isSuccess) {
        Navigator.pop(context, _gifts);
      } else {
        showToast(context, '🎁礼物保存失败，请重试');
      }
    }).catchError((err) {
      showToast(context, '🎁礼物保存失败，请重试');
    });
  }
  
}