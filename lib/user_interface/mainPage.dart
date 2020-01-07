import 'package:flutter/material.dart';

import 'package:spotify_more_or_less/user_interface/profilPage.dart';
import 'package:spotify_more_or_less/user_interface/highscorePage.dart';
import 'package:spotify_more_or_less/user_interface/categoryPage.dart';
import 'package:spotify_more_or_less/user_interface/shopPage.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 2;
  final List<Widget> pages = [
    ProfilPage(),
    HighscorePage(),
    CategoryPage(),
    ShopPage(),
  ];
  Widget currentScreen = CategoryPage();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Color.fromARGB(204, 27, 27, 27),
          child: Icon(Icons.play_arrow),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 9,
          elevation: 15,
          color: Color.fromARGB(204, 27, 27, 27),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // linke Icons (Profil und Ranglisten)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showProfilPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color:
                                currentPage == 0 ? Colors.white : Colors.grey,
                          ),
                          Text(
                            'Profil',
                            style: TextStyle(
                              color:
                                  currentPage == 0 ? Colors.white : Colors.grey,
                              fontWeight: currentPage == 0 ? FontWeight.w600 : FontWeight.w400,
                              fontSize: currentPage == 0 ? 13 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showHighscorePage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.equalizer,
                            color:
                                currentPage == 1 ? Colors.white : Colors.grey,
                          ),
                          Text(
                            'Ranglisten',
                            style: TextStyle(
                              color:
                                  currentPage == 1 ? Colors.white : Colors.grey,
                              fontWeight: currentPage == 1 ? FontWeight.w600 : FontWeight.w400,
                              fontSize: currentPage == 1 ? 13 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // rechte Icons (Kategorien und Shop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showCategoryPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.category,
                            color:
                            currentPage == 2 ? Colors.white : Colors.grey,
                          ),
                          Text(
                            'Kategorien',
                            style: TextStyle(
                              color:
                              currentPage == 2 ? Colors.white : Colors.grey,
                              fontWeight: currentPage == 2 ? FontWeight.w600 : FontWeight.w400,
                              fontSize: currentPage == 2 ? 13 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showShopPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.shop_two,
                            color:
                            currentPage == 3 ? Colors.white : Colors.grey,
                          ),
                          Text(
                            'Shop',
                            style: TextStyle(
                              color:
                              currentPage == 3 ? Colors.white : Colors.grey,
                              fontWeight: currentPage == 3 ? FontWeight.w600 : FontWeight.w400,
                              fontSize: currentPage == 3 ? 13 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProfilPage() {
    setState(() {
      currentScreen = ProfilPage();
      currentPage = 0;
    });
  }

  void _showHighscorePage() {
    setState(() {
      currentScreen = HighscorePage();
      currentPage = 1;
    });
  }

  void _showCategoryPage() {
    setState(() {
      currentScreen = CategoryPage();
      currentPage = 2;
    });
  }

  void _showShopPage() {
    setState(() {
      currentScreen = ShopPage();
      currentPage = 3;
    });
  }
}
