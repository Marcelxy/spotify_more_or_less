import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    Query userReference = Firestore.instance.collection('users').orderBy('hpWorldwide', descending: true).limit(10);

    return Scaffold(
        appBar: AppBar(
          title: Text('Ranglisten'),
          backgroundColor: Color.fromARGB(204, 27, 27, 27),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: userReference.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.5),
                      )),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(document['e-mail'][0]),
                        ),
                        title: Text(document['e-mail']),
                        subtitle: Text(document['hpWorldwide'].toString()),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ));
  }
}
