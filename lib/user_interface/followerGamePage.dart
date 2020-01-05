import 'package:flutter/material.dart';
import 'dart:math';

import 'package:spotify_more_or_less/datastructures/artist.dart';
import 'package:spotify_more_or_less/user_interface/mainPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class FollowerGamePage extends StatefulWidget {
  final List<Artist> artist;
  FollowerGamePage(this.artist);

  @override
  _FollowerGamePageState createState() => _FollowerGamePageState();
}

class _FollowerGamePageState extends State<FollowerGamePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool followerVisible = false;
  int highscorePoints = 0;
  int topArtist = 0;
  int bottomArtist = 0;
  Random random1 = new Random();
  Random random2 = new Random();
  MoneyFormatterOutput topArtistFollowerFormatter;
  MoneyFormatterOutput bottomArtistFollowerFormatter;

  @override
  void initState() {
    super.initState();
    topArtist = random1.nextInt(widget.artist.length - 1);
    bottomArtist = random2.nextInt(widget.artist.length - 1);
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(
            begin: 0.0,
            end: widget.artist[bottomArtist].numberOfFollower.toDouble())
        .animate(controller);
    controller.addListener(() {
      this.setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    while (topArtist == bottomArtist) {
      bottomArtist = random2.nextInt(widget.artist.length - 1);
    }
    animation = Tween(
            begin: 0.0,
            end: widget.artist[bottomArtist].numberOfFollower.toDouble())
        .animate(controller);
    topArtistFollowerFormatter = FlutterMoneyFormatter(
      amount: widget.artist[topArtist].numberOfFollower.toDouble(),
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        fractionDigits: 0,
      ),
    ).output;
    bottomArtistFollowerFormatter = FlutterMoneyFormatter(
      amount: animation.value,
      /*widget.artist[bottomArtist].numberOfFollower.toDouble(),*/
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        fractionDigits: 0,
      ),
    ).output;
    return MaterialApp(
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
                    imageUrl: widget.artist[topArtist].image,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
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
                          text: '${widget.artist[topArtist].name}\n',
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
                    imageUrl: widget.artist[bottomArtist].image,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.artist[bottomArtist].name,
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
                        child: FlatButton(
                          onPressed: () => _answerMore(),
                          child: Text('Mehr',
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
                        visible: !followerVisible,
                      ),
                      Visibility(
                        child: FlatButton(
                          onPressed: () => _answerLess(),
                          child: Text(
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
                          child: Text('Weiter',
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
                        visible: followerVisible,
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
    setState(() {
      followerVisible = false;
      highscorePoints++;
      topArtist = bottomArtist;
      bottomArtist = random2.nextInt(widget.artist.length - 1);
    });
  }

  void _answerMore() {
    if (widget.artist[topArtist].numberOfFollower >
        widget.artist[bottomArtist].numberOfFollower) {
      _wrongAnswer();
    } else {
      _rightAnswer();
    }
  }

  void _answerLess() {
    if (widget.artist[topArtist].numberOfFollower <
        widget.artist[bottomArtist].numberOfFollower) {
      _wrongAnswer();
    } else {
      _rightAnswer();
    }
  }

  void _rightAnswer() {
    followerVisible = true;
    controller.forward(from: 0.0);
  }

  void _wrongAnswer() {
    followerVisible = true;
    showDialog(
        context: context,
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
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage())),
              ),
            ],
          );
        });
    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
