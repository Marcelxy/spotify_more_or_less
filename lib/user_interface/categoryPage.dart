import 'package:flutter/material.dart';
import 'dart:math';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:spotify/spotify_io.dart' as spotifyApi;

import 'package:spotify_more_or_less/datastructures/artist.dart';
import 'package:spotify_more_or_less/user_interface/followerGamePage.dart';
import 'package:spotify_more_or_less/datastructures/globalArtists.dart';
import 'package:spotify_more_or_less/datastructures/categories.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
      appBar: AppBar(
        title: Text('Kategorien'),
        backgroundColor: Color.fromARGB(204, 27, 27, 27),
      ),
      body: GridView.builder(
          itemCount: Categories.categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('${Categories.categories[index]}'),
                  ),
                ),
              ),
              onTap: () => _chooseCategory(),
            );
          }),
    );
  }

  void _chooseCategory() async {
    _progressDialog.show();
    var credentials =
        new spotifyApi.SpotifyApiCredentials('b9754ebac220485796ecd4b460193fe9', '5d7d58000a0841e6b133baa0f19a405b');
    var spotify = new spotifyApi.SpotifyApi(credentials);

    List<Artist> artistList = new List<Artist>();
    Random firstRandom = new Random();
    Random secondRandom = new Random();

    int firstRandomArtist = firstRandom.nextInt(GlobalArtists.spotifyArtistId.length);
    int secondRandomArtist = secondRandom.nextInt(GlobalArtists.spotifyArtistId.length);
    var firstSpotifyArtist = await spotify.artists.get(GlobalArtists.spotifyArtistId[firstRandomArtist]);
    var secondSpotifyArtist = await spotify.artists.get(GlobalArtists.spotifyArtistId[secondRandomArtist]);

    while (firstSpotifyArtist.name == secondSpotifyArtist.name) {
      secondRandomArtist = secondRandom.nextInt(GlobalArtists.spotifyArtistId.length);
      secondSpotifyArtist = await spotify.artists.get(GlobalArtists.spotifyArtistId[secondRandomArtist]);
    }

    Artist firstArtist =
        new Artist(firstSpotifyArtist.name, firstSpotifyArtist.images[0].url, firstSpotifyArtist.followers.total);
    Artist secondArtist =
        new Artist(secondSpotifyArtist.name, secondSpotifyArtist.images[0].url, secondSpotifyArtist.followers.total);
    artistList.add(firstArtist);
    artistList.add(secondArtist);

    /*for (int i = 0; i < artistList.length; i++) {
      print("Name: ${artistList[i].name}");
      print("Anzahl Follower: ${artistList[i].numberOfFollower}");
    }*/
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      _progressDialog.hide().whenComplete(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowerGamePage(artistList)));
      });
    });
  }
}
