import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spotify_more_or_less/datastructures/categories.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

class HighscorePage extends StatefulWidget {
  @override
  _HighscorePageState createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {
  String _selectedDropdownItem;
  String selectedCategorie;

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
    _selectedDropdownItem = Categories.categories[0];
    selectedCategorie = 'global';
  }

  @override
  Widget build(BuildContext context) {
    Query userReference = Firestore.instance
        .collection('users')
        .orderBy('highscorePoints.$selectedCategorie', descending: true)
        .limit(10);

    return Scaffold(
        body: Container(
      color: Color.fromARGB(218, 0, 0, 0),
      child: Column(
        children: <Widget>[
          DropdownButton(
            isExpanded: true,
            value: _selectedDropdownItem,
            items: Categories.categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _chooseHighscoreList(Categories.categories.indexOf(newValue));
                _selectedDropdownItem = newValue;
              });
            },
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: userReference.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView(
                      children: snapshot.data.documents.map((DocumentSnapshot document) {
                        List<dynamic> highscores =
                            snapshot.data.documents[snapshot.data.documents.indexOf(document)].data.values.toList();
                        print(highscores);
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 0.5, color: Colors.white),
                          )),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                document['e-mail'][0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              document['e-mail'],
                              style: TextStyle(color: Colors.white70),
                            ),
                            subtitle: Text(
                              highscores[1][selectedCategorie].toString(),
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  void _chooseHighscoreList(int index) {
    switch (index) {
      case 0:
        selectedCategorie = 'global';
        break;
      case 1:
        selectedCategorie = 'germany';
        break;
      case 2:
        selectedCategorie = 'greatBritain';
        break;
      case 2:
        selectedCategorie = 'eighty';
        break;
      default:
        print('Falsche Index Übergabe bei Auswahl der HighscoreList aufgetreten.');
    }
  }
}
