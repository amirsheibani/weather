import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class IceWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  IceWidget(this.dayState, this.width, this.height);

  @override
  _IceWidgetState createState() => _IceWidgetState();
}

class _IceWidgetState extends State<IceWidget> with TickerProviderStateMixin {

  AnimationController _iceController;
  Animation _iceAnimationFadeTransition;

  String _iceImagePath;

  @override
  void initState() {

    _iceController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _iceAnimationFadeTransition = Tween(
        begin: 0.3,
        end: 1.0
    ).animate(_iceController);

    super.initState();
  }

  @override
  void didUpdateWidget(IceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _iceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          _iceImagePath = 'assets/images/ice.png';
        }
        break;
      case DayState.afternoon:
        {
          _iceImagePath = 'assets/images/ice.png';
        }
        break;
      case DayState.evening:
        {
          _iceImagePath = 'assets/images/ice.png';
        }
        break;
      case DayState.night:
        {
          _iceImagePath = 'assets/images/ice.png';
        }
        break;
    }
    return Stack(
      children: [
        Transform(
          transform: Matrix4.translationValues(10, 10, 0.0),
          child: FadeTransition(
            opacity: _iceAnimationFadeTransition,
            child: Container(
              width: (widget.width / 3) * 2,
              height: (widget.height / 3) * 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(_iceImagePath),
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