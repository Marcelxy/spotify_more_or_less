import 'package:flutter/material.dart';
import 'dart:math';

import 'package:spotify_more_or_less/datastructures/artist.dart';
import 'package:spotify_more_or_less/user_interface/mainPage.dart';
import 'package:spotify_more_or_less/datastructures/globalArtists.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:spotify/spotify_io.dart' as spotifyApi;

class FollowerGamePage extends StatefulWidget {
  final List<Artist> artistList;
  FollowerGamePage(this.artistList);

  @override
  _FollowerGamePageState createState() => _FollowerGamePageState();
}

class _FollowerGamePageState extends State<FollowerGamePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool followerVisible = false;
  bool furtherVisible = false;
  bool wrongAnswer = false;
  int highscorePoints = 0;
  int currentArtist = 0;
  var spotifyArtist;
  var credentials;
  var spotify;
  Random random = new Random();

  MoneyFormatterOutput topArtistFollowerFormatter;
  MoneyFormatterOutput bottomArtistFollowerFormatter;

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
    credentials =
        new spotifyApi.SpotifyApiCredentials('b9754ebac220485796ecd4b460193fe9', '5d7d58000a0841e6b133baa0f19a405b');
    spotify = new spotifyApi.SpotifyApi(credentials);
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    controller.addListener(() {
      this.setState(() {});
      if (controller.isCompleted) {
        if (wrongAnswer == false) {
          furtherVisible = true;
        } else {
          _showGameEndDialog();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    animation = Tween(begin: 0.0, end: widget.artistList.last.numberOfFollower.toDouble()).animate(controller);
    _formatFollowerNumber();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify More or Less',
      home: Scaffold(
        backgroundColor: Color.fromARGB(204, 27, 27, 27),
        appBar: AppBar(
          title: Text('Spotify More or Less'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(204, 27, 27, 27),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text(
              'Highscore: $highscorePoints',
              style: TextStyle(color: Colors.white),
            ),
            Flexible(
              flex: 1,
              child: Stack(children: <Widget>[
                Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.artistList[widget.artistList.length - 2].image,
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Center(
                    child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${widget.artistList[widget.artistList.length - 2].name}\n',
                        style: TextStyle(
                          inherit: true,
                          fontSize: 24.0,
                          color: Colors.yellowAccent.shade700,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black),
                            Shadow(
                                // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black),
                          ],
                        ),
                      ),
                      TextSpan(text: 'hat\n'),
                      TextSpan(
                        text: '${topArtistFollowerFormatter.nonSymbol}\n',
                        style: TextStyle(
                          inherit: true,
                          fontSize: 24.0,
                          color: Colors.yellowAccent.shade700,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black),
                            Shadow(
                                // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black),
                          ],
                        ),
                      ),
                      TextSpan(text: 'Follower auf Spotify'),
                    ],
                  ),
                )),
              ]),
            ),
            Flexible(
              flex: 1,
              child: Stack(children: <Widget>[
                Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.artistList.last.image,
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.artistList.last.name,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 24.0,
                          color: Colors.yellowAccent.shade700,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black),
                            Shadow(
                                // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black),
                          ],
                        ),
                      ),
                      Text(
                        'hat',
                        style: TextStyle(color: Colors.white),
                      ),
                      Visibility(
                        child: SizedBox(
                          width: 130,
                          child: FlatButton.icon(
                            onPressed: () => _answerMore(),
                            icon: Icon(Icons.arrow_drop_up, color: Colors.white),
                            label: Text(
                              'Mehr',
                              style: TextStyle(
                                inherit: true,
                                fontSize: 18.0,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topRight
                                      offset: Offset(1.5, 1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-1.5, 1.5),
                                      color: Colors.black),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        visible: !followerVisible,
                      ),
                      Visibility(
                        child: SizedBox(
                          width: 130,
                          child: FlatButton.icon(
                            onPressed: () => _answerLess(),
                            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                            label: Text(
                              'Weniger',
                              style: TextStyle(
                                inherit: true,
                                fontSize: 18.0,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topRight
                                      offset: Offset(1.5, 1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-1.5, 1.5),
                                      color: Colors.black),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        visible: !followerVisible,
                      ),
                      Visibility(
                        child: Text(
                          '${bottomArtistFollowerFormatter.nonSymbol}',
                          style: TextStyle(
                            inherit: true,
                            fontSize: 24.0,
                            color: Colors.yellowAccent.shade700,
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.black),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.black),
                              Shadow(
                                  // topRight
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.black),
                              Shadow(
                                  // topLeft
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        visible: followerVisible,
                      ),
                      Text(
                        'Follower auf Spotify',
                        style: TextStyle(color: Colors.white),
                      ),
                      Visibility(
                        child: FlatButton(
                          onPressed: () => _nextRound(),
                          child: Text(
                            'Weiter',
                            style: TextStyle(
                              inherit: true,
                              fontSize: 24.0,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-1.5, -1.5),
                                    color: Colors.black),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(1.5, -1.5),
                                    color: Colors.black),
                                Shadow(
                                    // topRight
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.black),
                                Shadow(
                                    // topLeft
                                    offset: Offset(-1.5, 1.5),
                                    color: Colors.black),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        visible: furtherVisible,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        )),
      ),
    );
  }

  void _nextRound() async {
    highscorePoints++;
    setState(() {
      Artist artist = new Artist(spotifyArtist.name, spotifyArtist.images[0].url, spotifyArtist.followers.total);
      widget.artistList.add(artist);
      followerVisible = false;
      furtherVisible = false;
    });
  }

  void _answerMore() {
    if (widget.artistList[widget.artistList.length - 2].numberOfFollower > widget.artistList.last.numberOfFollower) {
      _wrongAnswer();
    } else {
      _rightAnswer();
    }
  }

  void _answerLess() {
    if (widget.artistList[widget.artistList.length - 2].numberOfFollower < widget.artistList.last.numberOfFollower) {
      _wrongAnswer();
    } else {
      _rightAnswer();
    }
  }

  Future<void> _rightAnswer() async {
    try {
      followerVisible = true;
      controller.forward(from: 0.0);
      int nextArtist = random.nextInt(GlobalArtists.spotifyArtistId.length);
      spotifyArtist = await spotify.artists.get(GlobalArtists.spotifyArtistId[nextArtist]);
      while (spotifyArtist.name == widget.artistList.last.name) {
        nextArtist = random.nextInt(GlobalArtists.spotifyArtistId.length);
        spotifyArtist = await spotify.artists.get(GlobalArtists.spotifyArtistId[nextArtist]);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _wrongAnswer() {
    wrongAnswer = true;
    followerVisible = true;
    controller.forward(from: 0.0);
  }

  void _showGameEndDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Falsche Antwort'),
            content: Text('Erreichte Punktzahl: $highscorePoints'),
            actions: <Widget>[
              /* TODO direkt neues Spiel starten implementieren.
          RaisedButton(
            child: Text('Neues Spiel'),
            onPressed: null,
          ),*/
              RaisedButton(
                child: Text('Spiel beenden'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())),
              ),
            ],
          );
        });
  }

  void _formatFollowerNumber() {
    topArtistFollowerFormatter = FlutterMoneyFormatter(
      amount: widget.artistList[widget.artistList.length - 2].numberOfFollower.toDouble(),
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        fractionDigits: 0,
      ),
    ).output;
    bottomArtistFollowerFormatter = FlutterMoneyFormatter(
      amount: animation.value,
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        fractionDigits: 0,
      ),
    ).output;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
