import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class FogWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  FogWidget(this.dayState, this.width, this.height);

  @override
  _FogWidgetState createState() => _FogWidgetState();
}

class _FogWidgetState extends State<FogWidget> with TickerProviderStateMixin {

  AnimationController _hazyController;
  Animation _hazyAnimationFadeTransition;

  String _hazyImagePath;

  @override
  void initState() {

    _hazyController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _hazyAnimationFadeTransition = Tween(
        begin: 0.3,
        end: 1.0
    ).animate(_hazyController);

    super.initState();
  }

  @override
  void didUpdateWidget(FogWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _hazyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
      case DayState.afternoon:
        {
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
      case DayState.evening:
        {
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
      case DayState.night:
        {
          _hazyImagePath = 'assets/images/hazy.png';
        }
        break;
    }
    return Stack(
      children: [
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