import 'package:flutter/material.dart';

import 'package:spotify_more_or_less/helper/systemSettings.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Shop'),
      backgroundColor: Color.fromARGB(204, 27, 27, 27),
    ));
  }
}
