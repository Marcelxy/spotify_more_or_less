import 'package:flutter/material.dart';

class FollowerAnimation extends StatefulWidget {
  @override
  _FollowerAnimationState createState() => _FollowerAnimationState();
}

class _FollowerAnimationState extends State<FollowerAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.addListener(() {
      this.setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector();
  }
}
