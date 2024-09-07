import 'package:flutter/material.dart';
import 'package:reminderapp/screens/setting.dart';

import 'note_book_list.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<StatefulWidget> createState() => _homeState();
}

class _homeState extends State<home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(_selectedIndex);
    });
  }

  List<String> HomePageName = <String>["Home", "Setting"];
  List<Widget> HomePageWidget = <Widget>[const NoteBookList(), const Setting()];
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text(HomePageName.elementAt(_selectedIndex)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        body: PageView(
            controller: pageController,
            children: const [NoteBookList(), Setting()],
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ],
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue,
            currentIndex: _selectedIndex));
  }
}
