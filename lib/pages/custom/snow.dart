import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class SnowWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  SnowWidget(this.dayState, this.width, this.height);

  @override
  _SnowWidgetState createState() => _SnowWidgetState();
}

class _SnowWidgetState extends State<SnowWidget> with TickerProviderStateMixin {

  AnimationController _cloudController;
  AnimationController _snowOneController;
  AnimationController _snowTwoController;

  Animation<Offset> _cloudOneAnimationSlideTransition;
  Animation<Offset> _cloudTwoAnimationSlideTransition;

  Animation<Offset> _snowOneAnimationSlideTransition;
  Animation<Offset> _snowTwoAnimationSlideTransition;

  Animation _snowOneAnimationFadeTransition;
  Animation _snowTwoAnimationFadeTransition;

  String _cloudImagePath;
  String _snowImagePath;

  @override
  void initState() {
    _cloudController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat(reverse: true);

    _snowOneController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: false);
    _snowTwoController = AnimationController(
      duration: const Duration(milliseconds: 6000),
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

    _snowOneAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _snowOneController,
      curve: Curves.ease,
    ));

    _snowTwoAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _snowTwoController,
      curve: Curves.ease,
    ));

    _snowOneAnimationFadeTransition = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(_snowOneController);

    _snowTwoAnimationFadeTransition = Tween(
        begin: 1.0,
        end: 0.0
    ).animate(_snowTwoController);

    super.initState();
  }

  @override
  void didUpdateWidget(SnowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cloudController.dispose();
    _snowOneController.dispose();
    _snowTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _cloudImagePath = 'assets/images/cloud_morning.png';
          _snowImagePath = 'assets/images/snow_morning.png';
        }
        break;
      case DayState.afternoon:
        {
          _cloudImagePath = 'assets/images/cloud_evening.png';
          _snowImagePath = 'assets/images/snow_evening.png';
        }
        break;
      case DayState.evening:
        {
          _cloudImagePath = 'assets/images/cloud_night.png';
          _snowImagePath = 'assets/images/snow_night.png';
        }
        break;
      case DayState.night:
        {
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
          _snowImagePath = 'assets/images/snow_afternoon.png';
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
            position: _snowOneAnimationSlideTransition,
            child: FadeTransition(
              opacity: _snowOneAnimationFadeTransition,
              child: Container(
                width: (widget.width/3) * 1.5,
                height: (widget.height/3) * 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(_snowImagePath),
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
            position: _snowTwoAnimationSlideTransition,
            child: FadeTransition(
              opacity: _snowTwoAnimationFadeTransition,
              child: Container(
                width: (widget.width/3) * 1.5,
                height: (widget.height/3) * 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(_snowImagePath),
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