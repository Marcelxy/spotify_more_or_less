import 'package:flutter/material.dart';

import 'package:spotify_more_or_less/datastructures/artist.dart';
import 'package:spotify_more_or_less/datastructures/credentials.dart';
import 'package:spotify_more_or_less/user_interface/mainPage.dart';
import 'package:spotify_more_or_less/helper/systemSettings.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:spotify/spotify_io.dart' as spotifyApi;

class FollowerGamePage extends StatefulWidget {
  int highscorePoints;
  final List<Artist> artistList;
  final List<String> artistIdList;
  FollowerGamePage(this.artistList, this.artistIdList, this.highscorePoints);

  @override
  _FollowerGamePageState createState() => _FollowerGamePageState();
}

class _FollowerGamePageState extends State<FollowerGamePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool followerVisible = false;
  bool furtherVisible = false;
  bool wrongAnswer = false;
  int currentPoints;
  var spotifyArtist;
  var spotify;

  MoneyFormatterOutput topArtistFollowerFormatter;
  MoneyFormatterOutput bottomArtistFollowerFormatter;

  @override
  void initState() {
    super.initState();
    SystemSettings.allowOnlyPortraitOrientation();
    currentPoints = 0;
    var credentials = new spotifyApi.SpotifyApiCredentials(Credentials.clientId, Credentials.clientSecret);
    spotify = new spotifyApi.SpotifyApi(credentials);
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    controller.addListener(() {
      this.setState(() {
        if (controller.isCompleted) {
          if (wrongAnswer == false) {
            furtherVisible = true;
          } else {
            _showGameEndDialog();
          }
        }
      });
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
        body: Center(
            child: Column(
          children: <Widget>[
            Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(63.0, 35.0, 0.0, 10.0),
                    child: Text(
                      'Punktzahl: $currentPoints',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(63.0, 35.0, 0.0, 10.0),
                    child: Text(
                      'Highscore: ${widget.highscorePoints}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(children: <Widget>[
                Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.artistList[widget.artistList.length - 2].image,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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

  void _nextRound() {
    if (spotifyArtist.name != null) {
      Artist artist = new Artist(spotifyArtist.name, spotifyArtist.images[0].url, spotifyArtist.followers.total);
      widget.artistList.add(artist);
      setState(() {
        currentPoints++;
        followerVisible = false;
        furtherVisible = false;
      });
    }
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
      spotifyArtist = await spotify.artists.get(widget.artistIdList[widget.artistList.length]);
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
            content: Text('Erreichte Punktzahl: $currentPoints'),
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
