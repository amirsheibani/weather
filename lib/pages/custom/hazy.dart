import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class HazyWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  HazyWidget(this.dayState, this.width, this.height);

  @override
  _HazyWidgetState createState() => _HazyWidgetState();
}

class _HazyWidgetState extends State<HazyWidget> with TickerProviderStateMixin {
  AnimationController _sunnyController;
  Animation<double> _sunnyAnimationRotationTransition;

  AnimationController _hazyController;
  Animation _hazyAnimationFadeTransition;

  String _sunnyImagePath;
  String _hazyImagePath;

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

    _hazyController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _hazyAnimationFadeTransition = Tween(
        begin: 0.3,
        end: 0.5
    ).animate(_hazyController);

    super.initState();
  }

  @override
  void didUpdateWidget(HazyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _sunnyController.dispose();
    _hazyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _sunnyImagePath = 'assets/images/sunny_morning.png';
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
      case DayState.afternoon:
        {
          _sunnyImagePath = 'assets/images/sunny_evening.png';
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
      case DayState.evening:
        {
          _sunnyImagePath = 'assets/images/sunny_night.png';
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
      case DayState.night:
        {
          _sunnyImagePath = 'assets/images/moon_afternoon.png';
          _hazyImagePath = 'assets/images/hazy.png';
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
    transform: Matrix4.translationValues(0, 10, 0.0),
          child: FadeTransition(
            opacity: _hazyAnimationFadeTransition,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(_hazyImagePath),
                  fit: BoxFit.fill,
                ),
                // shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}