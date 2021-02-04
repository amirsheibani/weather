import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class MostlyCloudySnowWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  MostlyCloudySnowWidget(this.dayState, this.width, this.height);

  @override
  _MostlyCloudySnowWidgetState createState() => _MostlyCloudySnowWidgetState();
}

class _MostlyCloudySnowWidgetState extends State<MostlyCloudySnowWidget> with TickerProviderStateMixin {
  AnimationController _sunnyController;
  AnimationController _cloudController;
  AnimationController _snowOneController;
  AnimationController _snowTwoController;

  Animation<double> _sunnyAnimationRotationTransition;

  Animation<Offset> _cloudOneAnimationSlideTransition;
  Animation<Offset> _cloudTwoAnimationSlideTransition;

  Animation _cloudOneAnimationFadeTransition;
  Animation _cloudTwoAnimationFadeTransition;

  Animation<Offset> _snowOneAnimationSlideTransition;
  Animation<Offset> _snowTwoAnimationSlideTransition;

  Animation _snowOneAnimationFadeTransition;
  Animation _snowTwoAnimationFadeTransition;


  String _sunnyImagePath;
  String _cloudImagePath;
  String _snowImagePath;

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

    _snowOneController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: false);
    _snowTwoController = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    )..repeat(reverse: false);

    _cloudController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

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

    _cloudOneAnimationFadeTransition = Tween(
        begin: 0.70,
        end: 0.85
    ).animate(_cloudController);

    _cloudTwoAnimationFadeTransition = Tween(
        begin: 0.70,
        end: 0.85
    ).animate(_cloudController);


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
        begin: 0.1,
        end: 0.85
    ).animate(_snowOneController);

    _snowTwoAnimationFadeTransition = Tween(
        begin: 0.85,
        end: 0.1
    ).animate(_snowTwoController);

    super.initState();
  }

  @override
  void didUpdateWidget(MostlyCloudySnowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _sunnyController.dispose();
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
          _sunnyImagePath = 'assets/images/sunny_morning.png';
          _cloudImagePath = 'assets/images/cloud_morning.png';
          _snowImagePath = 'assets/images/snow_morning.png';
        }
        break;
      case DayState.afternoon:
        {
          _sunnyImagePath = 'assets/images/sunny_evening.png';
          _cloudImagePath = 'assets/images/cloud_evening.png';
          _snowImagePath = 'assets/images/snow_evening.png';
        }
        break;
      case DayState.evening:
        {
          _sunnyImagePath = 'assets/images/sunny_night.png';
          _cloudImagePath = 'assets/images/cloud_night.png';
          _snowImagePath = 'assets/images/snow_night.png';
        }
        break;
      case DayState.night:
        {
          _sunnyImagePath = 'assets/images/moon_afternoon.png';
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
          _snowImagePath = 'assets/images/snow_afternoon.png';
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
          transform: Matrix4.translationValues(0, 40, 0.0),
          child: SlideTransition(
            position: _cloudOneAnimationSlideTransition,
            child: FadeTransition(
              opacity: _cloudOneAnimationFadeTransition,
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
        ),
        Transform(
          transform: Matrix4.translationValues(70, 20, 0.0),
          child: SlideTransition(
            position: _cloudTwoAnimationSlideTransition,
            child: FadeTransition(
              opacity: _cloudTwoAnimationFadeTransition,
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
        ),
        Transform(
          transform: Matrix4.translationValues(33, 150, 0.0),
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
          transform: Matrix4.translationValues(38, 140, 0.0),
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