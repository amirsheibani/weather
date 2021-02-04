import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class SunnyWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  SunnyWidget(this.dayState, this.width, this.height);

  @override
  _SunnyWidgetState createState() => _SunnyWidgetState();
}

class _SunnyWidgetState extends State<SunnyWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String _imagePath;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: false);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    super.initState();
  }
  @override
  void didUpdateWidget(SunnyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch(widget.dayState){
      case DayState.morning:{
        _imagePath = 'assets/images/sunny_morning.png';
      }break;
      case DayState.afternoon:{
        _imagePath = 'assets/images/sunny_evening.png';
      }break;
      case DayState.evening:{
        _imagePath = 'assets/images/sunny_night.png';
      }break;
      case DayState.night:{
        _imagePath = 'assets/images/moon_afternoon.png';
      }break;
    }
    return RotationTransition(
      turns: _animation,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(_imagePath),
          fit: BoxFit.fill,
        ),
        // shape: BoxShape.rectangle,
      ),),
    );
  }
}