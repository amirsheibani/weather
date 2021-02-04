import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class PartlySunnyTStormsWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  PartlySunnyTStormsWidget(this.dayState, this.width, this.height);

  @override
  _PartlySunnyTStormsWidgetState createState() => _PartlySunnyTStormsWidgetState();
}

class _PartlySunnyTStormsWidgetState extends State<PartlySunnyTStormsWidget> with TickerProviderStateMixin {
  AnimationController _sunnyController;
  AnimationController _thunderStormController;


  Animation<double> _sunnyAnimationRotationTransition;
  AnimationController _cloudController;
  Animation<Offset> _cloudAnimationSlideTransition;
  Animation _cloudAnimationFadeTransition;
  Animation _thunderStormAnimationFadeTransition;

  String _sunnyImagePath;
  String _cloudImagePath;
  String _rainImagePath;
  String _thunderStormImagePath;

  @override
  void initState() {
    _sunnyController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: false);

    _thunderStormController = AnimationController(
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

    _thunderStormAnimationFadeTransition = Tween(
        begin: 0.0,
        end: 0.5
    ).animate(_thunderStormController);

    super.initState();
  }

  @override
  void didUpdateWidget(PartlySunnyTStormsWidget oldWidget) {
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
          _rainImagePath = 'assets/images/rain_morning.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
      case DayState.afternoon:
        {
          _sunnyImagePath = 'assets/images/sunny_evening.png';
          _cloudImagePath = 'assets/images/cloud_evening.png';
          _rainImagePath = 'assets/images/rain_evening.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
      case DayState.evening:
        {
          _sunnyImagePath = 'assets/images/sunny_night.png';
          _cloudImagePath = 'assets/images/cloud_night.png';
          _rainImagePath = 'assets/images/rain_night.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
      case DayState.night:
        {
          _sunnyImagePath = 'assets/images/sunny_afternoon.png';
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
          _rainImagePath = 'assets/images/rain_afternoon.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
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
        Transform(
          transform: Matrix4.translationValues(30, 120, 0.0),
          child: SlideTransition(
            position: _cloudAnimationSlideTransition,
            child: FadeTransition(
              opacity: _cloudAnimationFadeTransition,
              child: Container(
                width: widget.width/3,
                height: widget.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(_rainImagePath),
                    fit: BoxFit.fill,
                  ),
                  // shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(30, 100, 0.0),
          child: SlideTransition(
            position: _cloudAnimationSlideTransition,
            child: FadeTransition(
              opacity: _thunderStormAnimationFadeTransition,
              child: Container(
                width: widget.width/3,
                height: widget.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(_thunderStormImagePath),
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