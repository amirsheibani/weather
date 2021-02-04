import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class SleetWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  SleetWidget(this.dayState, this.width, this.height);

  @override
  _SleetWidgetState createState() => _SleetWidgetState();
}

class _SleetWidgetState extends State<SleetWidget> with TickerProviderStateMixin {

  AnimationController _cloudController;
  AnimationController _snowController;
  AnimationController _showersController;

  Animation<Offset> _cloudOneAnimationSlideTransition;
  Animation<Offset> _cloudTwoAnimationSlideTransition;

  Animation<Offset> _snowAnimationSlideTransition;
  Animation<Offset> _showersAnimationSlideTransition;

  Animation _snowAnimationFadeTransition;
  Animation _showersAnimationFadeTransition;

  String _cloudImagePath;
  String _snowImagePath;
  String _showersImagePath;

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
    _showersController = AnimationController(
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

    _showersAnimationSlideTransition = Tween<Offset>(
      begin: const Offset(-0.1, -0.1),
      end: const Offset(0.1, 0.1),
    ).animate(CurvedAnimation(
      parent: _showersController,
      curve: Curves.ease,
    ));

    _snowAnimationFadeTransition = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(_snowController);

    _showersAnimationFadeTransition = Tween(
        begin: 1.0,
        end: 0.0
    ).animate(_showersController);

    super.initState();
  }

  @override
  void didUpdateWidget(SleetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cloudController.dispose();
    _snowController.dispose();
    _showersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _cloudImagePath = 'assets/images/cloud_morning.png';
          _snowImagePath = 'assets/images/snow_morning.png';
          _showersImagePath = 'assets/images/showers_morning.png';
        }
        break;
      case DayState.afternoon:
        {
          _cloudImagePath = 'assets/images/cloud_evening.png';
          _snowImagePath = 'assets/images/snow_evening.png';
          _showersImagePath = 'assets/images/showers_evening.png';
        }
        break;
      case DayState.evening:
        {
          _cloudImagePath = 'assets/images/cloud_night.png';
          _snowImagePath = 'assets/images/snow_night.png';
          _showersImagePath = 'assets/images/showers_night.png';
        }
        break;
      case DayState.night:
        {
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
          _snowImagePath = 'assets/images/snow_afternoon.png';
          _showersImagePath = 'assets/images/showers_afternoon.png';
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
            position: _showersAnimationSlideTransition,
            child: FadeTransition(
              opacity: _showersAnimationFadeTransition,
              child: Container(
                width: (widget.width/3) * 1.5,
                height: (widget.height/3) * 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(_showersImagePath),
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