import 'package:flutter/material.dart';

import 'package:spotify_more_or_less/helper/systemSettings.dart';

class HighscorePage extends StatefulWidget {
  @override
  _HighscorePageState createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Ranglisten'),
      backgroundColor: Color.fromARGB(204, 27, 27, 27),
    ));
  }
}
