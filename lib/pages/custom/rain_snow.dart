import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class RainSnowWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  RainSnowWidget(this.dayState, this.width, this.height);

  @override
  _RainSnowWidgetState createState() => _RainSnowWidgetState();
}

class _RainSnowWidgetState extends State<RainSnowWidget> with TickerProviderStateMixin {

  AnimationController _cloudController;
  AnimationController _snowController;
  AnimationController _rainController;

  Animation<Offset> _cloudOneAnimationSlideTransition;
  Animation<Offset> _cloudTwoAnimationSlideTransition;

  Animation<Offset> _snowAnimationSlideTransition;
  Animation<Offset> _rainAnimationSlideTransition;

  Animation _snowAnimationFadeTransition;
  Animation _rainAnimationFadeTransition;

  String _cloudImagePath;
  String _snowImagePath;
  String _rainImagePath;

  @override
  void initState() {
    _cloudController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat(reverse: true);

    _snowController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: false);
    _rainController = AnimationController(
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

    _snowAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _snowController,
      curve: Curves.ease,
    ));

    _rainAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _rainController,
      curve: Curves.ease,
    ));

    _snowAnimationFadeTransition = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(_snowController);

    _rainAnimationFadeTransition = Tween(
        begin: 1.0,
        end: 0.0
    ).animate(_rainController);

    super.initState();
  }

  @override
  void didUpdateWidget(RainSnowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cloudController.dispose();
    _snowController.dispose();
    _rainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _cloudImagePath = 'assets/images/cloud_morning.png';
          _snowImagePath = 'assets/images/snow_morning.png';
          _rainImagePath = 'assets/images/rain_morning.png';
        }
        break;
      case DayState.afternoon:
        {
          _cloudImagePath = 'assets/images/cloud_evening.png';
          _snowImagePath = 'assets/images/snow_evening.png';
          _rainImagePath = 'assets/images/rain_evening.png';
        }
        break;
      case DayState.evening:
        {
          _cloudImagePath = 'assets/images/cloud_night.png';
          _snowImagePath = 'assets/images/snow_night.png';
          _rainImagePath = 'assets/images/rain_night.png';
        }
        break;
      case DayState.night:
        {
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
          _snowImagePath = 'assets/images/snow_afternoon.png';
          _rainImagePath = 'assets/images/rain_afternoon.png';
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
            position: _snowAnimationSlideTransition,
            child: FadeTransition(
              opacity: _snowAnimationFadeTransition,
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
            position: _rainAnimationSlideTransition,
            child: FadeTransition(
              opacity: _rainAnimationFadeTransition,
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
      ],
    );
  }
}