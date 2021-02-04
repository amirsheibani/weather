import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class TStormsWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  TStormsWidget(this.dayState, this.width, this.height);

  @override
  _TStormsWidgetState createState() => _TStormsWidgetState();
}

class _TStormsWidgetState extends State<TStormsWidget> with TickerProviderStateMixin {

  AnimationController _cloudController;
  AnimationController _rainOneController;
  AnimationController _rainTwoController;
  AnimationController _thunderStormController;

  Animation<Offset> _cloudOneAnimationSlideTransition;
  Animation<Offset> _cloudTwoAnimationSlideTransition;

  Animation<Offset> _rainOneAnimationSlideTransition;
  Animation<Offset> _rainTwoAnimationSlideTransition;

  Animation _rainOneAnimationFadeTransition;
  Animation _rainTwoAnimationFadeTransition;

  Animation _thunderStormAnimationFadeTransition;

  String _cloudImagePath;
  String _rainImagePath;
  String _thunderStormImagePath;

  @override
  void initState() {
    _cloudController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat(reverse: true);

    _rainOneController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: false);
    _rainTwoController = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    )..repeat(reverse: false);

    _thunderStormController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: false);

    _cloudOneAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: _cloudController,
      curve: Curves.easeInOutQuad,
    ));

    _cloudTwoAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: _cloudController,
      curve: Curves.easeInOutQuad,
    ));

    _rainOneAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _rainOneController,
      curve: Curves.ease,
    ));

    _rainTwoAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _rainTwoController,
      curve: Curves.ease,
    ));

    _rainOneAnimationFadeTransition = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(_rainOneController);

    _rainTwoAnimationFadeTransition = Tween(
        begin: 1.0,
        end: 0.0
    ).animate(_rainTwoController);

    _thunderStormAnimationFadeTransition = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(_thunderStormController);

    super.initState();
  }

  @override
  void didUpdateWidget(TStormsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cloudController.dispose();
    _rainOneController.dispose();
    _rainTwoController.dispose();
    _thunderStormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _cloudImagePath = 'assets/images/cloud_morning.png';
          _rainImagePath = 'assets/images/rain_morning.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
      case DayState.afternoon:
        {
          _cloudImagePath = 'assets/images/cloud_evening.png';
          _rainImagePath = 'assets/images/rain_evening.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
      case DayState.evening:
        {
          _cloudImagePath = 'assets/images/cloud_night.png';
          _rainImagePath = 'assets/images/rain_night.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
      case DayState.night:
        {
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
          _rainImagePath = 'assets/images/rain_afternoon.png';
          _thunderStormImagePath = 'assets/images/thunder_storm.png';
        }
        break;
    }
    return Stack(
      children: [
        Transform(
          transform: Matrix4.translationValues(0, 40, 0.0),
          child: SlideTransition(
            position: _cloudOneAnimationSlideTransition,
            child: Container(
              width: (widget.width/3) * 2,
              height: (widget.height/3) * 2,
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
        Transform(
          transform: Matrix4.translationValues(70, 20, 0.0),
          child: SlideTransition(
            position: _cloudTwoAnimationSlideTransition,
            child: Container(
              width: (widget.width/3) * 1.5,
              height: (widget.height/3) * 1.5,
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
        Transform(
          transform: Matrix4.translationValues(35, 128, 0.0),
          child: SlideTransition(
            position: _rainOneAnimationSlideTransition,
            child: FadeTransition(
              opacity: _rainOneAnimationFadeTransition,
              child: Container(
                width: (widget.width/3) * 1.5,
                height: (widget.height/3) * 1.5,
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
          transform: Matrix4.translationValues(35, 128, 0.0),
          child: SlideTransition(
            position: _rainTwoAnimationSlideTransition,
            child: FadeTransition(
              opacity: _rainTwoAnimationFadeTransition,
              child: Container(
                width: (widget.width/3) * 1.5,
                height: (widget.height/3) * 1.5,
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
          transform: Matrix4.translationValues(25, 115, 0.0),
          child: SlideTransition(
            position: _cloudOneAnimationSlideTransition,
            child: FadeTransition(
              opacity: _thunderStormAnimationFadeTransition,
              child: Container(
                width: (widget.width/3) * 1.5,
                height: (widget.height/3) * 1.5,
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