import 'package:flutter/material.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/spotify_io.dart' as spotifyApi;

import 'package:spotify_more_or_less/datastructures/artist.dart';
import 'package:spotify_more_or_less/user_interface/followerGamePage.dart';
import 'package:spotify_more_or_less/datastructures/spotifyIdArtists.dart';
import 'package:spotify_more_or_less/datastructures/categories.dart';
import 'package:spotify_more_or_less/datastructures/credentials.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _highscoreCategorie;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
    _progressDialog =
        new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    _progressDialog.style(
      message: 'Spiel wird gestartet...',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(218, 0, 0, 0),
        child: GridView.builder(
            padding: EdgeInsets.only(top: 80.0),
            itemCount: Categories.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 10.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(Categories.topColor[index]), Color(Categories.bottomColor[index])],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              height: 152,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.favorite_border, color: Colors.white70, size: 20.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: Center(
                                  child: Text('${Categories.categories[index]}',
                                      style: TextStyle(fontSize: 16.0, color: Colors.white))),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 63.0, 16.0, 0.0),
                              child: Divider(thickness: 0.5, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24.0, 87.0, 24.0, 0.0),
                              child: FlatButton(
                                onPressed: () => _startGame(index),
                                color: Colors.black54,
                                child: Row(
                                  children: <Widget>[
                                    Text('Spielen', style: TextStyle(color: Colors.white)),
                                    Icon(Icons.arrow_right, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _startGame(int index) async {
    _progressDialog.show();
    var credentials =
        new spotifyApi.SpotifyApiCredentials(Credentials.clientId, Credentials.clientSecret);
    var spotify = new spotifyApi.SpotifyApi(credentials);

    List<String> spotifyIdArtistList = _chooseCategorieData(index);
    spotifyIdArtistList.shuffle();

    List<Artist> artistList = new List<Artist>();
    for (int i = 0; i < 2; i++) {
      var spotifyArtist = await spotify.artists.get(spotifyIdArtistList[i]);
      Artist artist = new Artist(spotifyArtist.name, spotifyArtist.images[0].url, spotifyArtist.followers.total);
      artistList.add(artist);
    }

    int highscorePoints = await _getHighscorePoints();
    print(highscorePoints);
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _progressDialog.hide().whenComplete(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FollowerGamePage(artistList, spotifyIdArtistList, highscorePoints)));
      });
    });
  }

  List<String> _chooseCategorieData(int index) {
    switch (index) {
      case 0:
        _highscoreCategorie = 'global';
        return SpotifyIdArtistsList.globalArtistIds;
        break;
      case 1:
        _highscoreCategorie = 'germany';
        return SpotifyIdArtistsList.germanArtistIds;
        break;
      case 2:
        _highscoreCategorie = 'greatBritain';
        return SpotifyIdArtistsList.greatBritainArtistIds;
        break;
      case 3:
        _highscoreCategorie = 'eighty';
        return SpotifyIdArtistsList.eightyArtistIds;
        break;
      default:
        print('Falsche Index Übergabe bei Auswahl der SpotifyIdAtristList aufgetreten.');
        return null;
    }
  }
  
  Future<int> _getHighscorePoints() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    var userData = await Firestore.instance.collection('users').document(user.uid).get();
    var userDataList = userData.data.values.toList();
    int highscorePoints = userDataList[1][_highscoreCategorie];
    return highscorePoints;
  }
}
