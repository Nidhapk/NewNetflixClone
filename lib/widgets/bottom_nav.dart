import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/colors.dart';
import 'package:newnetflixclone/screens/home_screen.dart';
import 'package:newnetflixclone/screens/hotandnew_screen.dart';
import 'package:newnetflixclone/screens/search_screen.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: black,
            height: 70,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                  ),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(
                    Icons.photo_library_outlined,
                  ),
                  text: 'New & Hot',
                )
              ],
              indicatorColor: Colors.transparent,
              labelColor: white,
              unselectedLabelColor: grey,
            ),
          ),
          body: const TabBarView(
              children: [HomeScreen(), SearchScreen(), HotandNew()]),
        ));
  }
}
