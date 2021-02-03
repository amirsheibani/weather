import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class CloudyWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  CloudyWidget(this.dayState, this.width, this.height);

  @override
  _CloudyWidgetState createState() => _CloudyWidgetState();
}

class _CloudyWidgetState extends State<CloudyWidget> with TickerProviderStateMixin {

  AnimationController _cloudController;

  Animation<Offset> _cloudOneAnimationSlideTransition;
  Animation<Offset> _cloudTwoAnimationSlideTransition;
  Animation _cloudOneAnimationFadeTransition;
  Animation _cloudTwoAnimationFadeTransition;

  String _cloudImagePath;

  @override
  void initState() {
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

    super.initState();
  }

  @override
  void didUpdateWidget(CloudyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _cloudImagePath = 'assets/images/cloud_morning.png';
        }
        break;
      case DayState.afternoon:
        {
          _cloudImagePath = 'assets/images/cloud_evening.png';
        }
        break;
      case DayState.evening:
        {
          _cloudImagePath = 'assets/images/cloud_night.png';
        }
        break;
      case DayState.night:
        {
          _cloudImagePath = 'assets/images/cloud_afternoon.png';
        }
        break;
    }
    return Stack(
      children: [
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
      ],
    );
  }
}