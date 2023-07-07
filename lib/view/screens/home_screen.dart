import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/model/homeScreenList.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;
  late PageController pageController;

  void onPageChanged(int page) {
    setState(() {
      pageIdx = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          onTap: navigationTapped,
          currentIndex: pageIdx,
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                  size: 25,
                )),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search, size: 25),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo, size: 25), label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 25), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 25), label: 'Profile'),
          ]),
      body: PageView(
        controller: pageController,
        children: homeScreenList,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
