import 'package:flutter/material.dart';
import 'package:weather/theme/theme.dart';

class WindyWidget extends StatefulWidget {
  final DayState dayState;
  final double width;
  final double height;

  WindyWidget(this.dayState, this.width, this.height);

  @override
  _WindyWidgetState createState() => _WindyWidgetState();
}

class _WindyWidgetState extends State<WindyWidget> with TickerProviderStateMixin {
  // AnimationController _sunnyController;
  // Animation<double> _sunnyAnimationRotationTransition;

  AnimationController _windyController;
  Animation _windyAnimationFadeTransition;

  // String _sunnyImagePath;
  String _windyImagePath;

  @override
  void initState() {
    // _sunnyController = AnimationController(
    //   duration: const Duration(milliseconds: 3000),
    //   vsync: this,
    // )..repeat(reverse: false);
    // _sunnyAnimationRotationTransition = CurvedAnimation(
    //   parent: _sunnyController,
    //   curve: Curves.ease,
    // );

    _windyController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _windyAnimationFadeTransition = Tween(
        begin: 0.4,
        end: 1.0
    ).animate(_windyController);

    super.initState();
  }

  @override
  void didUpdateWidget(WindyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // _sunnyController.dispose();
    _windyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dayState) {
      case DayState.morning:
        {
          // _sunnyImagePath = 'assets/images/sunny_morning.png';
          _windyImagePath = 'assets/images/windy_evening.png';

        }
        break;
      case DayState.afternoon:
        {
          // _sunnyImagePath = 'assets/images/sunny_evening.png';

          _windyImagePath = 'assets/images/windy_night.png';
        }
        break;
      case DayState.evening:
        {
          // _sunnyImagePath = 'assets/images/sunny_night.png';
          _windyImagePath = 'assets/images/windy_morning.png';
        }
        break;
      case DayState.night:
        {
          // _sunnyImagePath = 'assets/images/moon_afternoon.png';
          _windyImagePath = 'assets/images/windy_afternoon.png';
        }
        break;
    }
    return Stack(
      children: [
        // RotationTransition(
        //   turns: _sunnyAnimationRotationTransition,
        //   child: Container(
        //     width: widget.width,
        //     height: widget.height,
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: ExactAssetImage(_sunnyImagePath),
        //         fit: BoxFit.fill,
        //       ),
        //       // shape: BoxShape.rectangle,
        //     ),
        //   ),
        // ),
        Transform(
          transform: Matrix4.translationValues(20, 20, 0.0),
          child: FadeTransition(
            opacity: _windyAnimationFadeTransition,
            child: Container(
              width: (widget.width/3) * 2,
              height: (widget.height/3) * 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(_windyImagePath),
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