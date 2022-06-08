import 'package:flutter/material.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({Key? key}) : super(key: key);

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '통계',
            icon: Icon(Icons.signal_cellular_alt_rounded),
          ),
          BottomNavigationBarItem(
            label: '몸무게',
            icon: Icon(Icons.bathroom_rounded),
          ),
        ],
      ),
    );
  }
}

