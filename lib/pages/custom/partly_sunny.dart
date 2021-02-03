import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';


class PartlySunnyWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  PartlySunnyWidget(this.dayState, this.width, this.height);

  @override
  _PartlySunnyWidgetState createState() => _PartlySunnyWidgetState();
}

class _PartlySunnyWidgetState extends State<PartlySunnyWidget> with TickerProviderStateMixin {
  AnimationController _sunnyController;
  Animation<double> _sunnyAnimationRotationTransition;

  AnimationController _cloudController;
  Animation<Offset> _cloudAnimationSlideTransition;
  Animation _cloudAnimationFadeTransition;

  String _sunnyImagePath;
  String _cloudImagePath;

  @override
  void initState() {
    _sunnyController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: false);
    _sunnyAnimationRotationTransition = CurvedAnimation(
      parent: _sunnyController,
      curve: Curves.ease,
    );

    _cloudController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _cloudAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.3, 0.3),
    ).animate(CurvedAnimation(
      parent: _cloudController,
      curve: Curves.easeInOutQuad,
    ));

    _cloudAnimationFadeTransition = Tween(
        begin: 0.3,
        end: 0.5
    ).animate(_cloudController);

    super.initState();
  }

  @override
  void didUpdateWidget(PartlySunnyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _sunnyController.dispose();
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _sunnyImagePath = 'assets/images/sunny_morning.png';
          _cloudImagePath = 'assets/images/cloud_morning.png';
        }
        break;
      case DayState.afternoon:
        {
          _sunnyImagePath = 'assets/images/sunny_evening.png';
          _cloudImagePath = 'assets/images/cloud_evening.png';
        }
        break;
      case DayState.evening:
        {
          _sunnyImagePath = 'assets/images/sunny_night.png';
          _cloudImagePath = 'assets/images/cloud_night.png';
        }
        break;
      case DayState.night:
        {
          _sunnyImagePath = 'assets/images/sunny_afternoon.png';
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
        }
        break;
    }
    return Stack(
      children: [
        RotationTransition(
          turns: _sunnyAnimationRotationTransition,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(_sunnyImagePath),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.rectangle,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(40, 64, 0.0),
          child: SlideTransition(
            position: _cloudAnimationSlideTransition,
            child: FadeTransition(
              opacity: _cloudAnimationFadeTransition,
              child: Container(
                width: widget.width/3,
                height: widget.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(_cloudImagePath),
                    fit: BoxFit.fill,
                  ),
                  // shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}