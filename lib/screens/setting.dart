import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<StatefulWidget> createState() => _NoteBookListPageState();
}

class _NoteBookListPageState extends State<Setting> {
  int _selectedIndex = 0;

  List<String> HomePageName = <String>["Home", "Setting"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text("sg");
  }
}

class NoteBookItem {}
