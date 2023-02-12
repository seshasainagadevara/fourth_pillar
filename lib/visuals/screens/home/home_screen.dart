import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/visuals/parts/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (pindex) {
              setState(() {
                pageIndex = pindex;
              });
            },
            backgroundColor: Colors.white.withOpacity(0.1),
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.inbox_outlined,
                  size: 30,
                ),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: 'Profile',
              ),
            ]),
        body: homePages[pageIndex]);
  }
}
