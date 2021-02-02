import 'package:flutter/material.dart';

class DayStateInformationWidget extends StatefulWidget {
  @override
  _DayStateInformationWidgetState createState() => _DayStateInformationWidgetState();
}

class _DayStateInformationWidgetState extends State<DayStateInformationWidget> with TickerProviderStateMixin {

  bool _show = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didUpdateWidget(DayStateInformationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double startPos = 1.0;
    double endPos = 0.0;
    Curve curve = Curves.elasticOut;
    Future.delayed(Duration(milliseconds: 1000), (){
      if (this.mounted) {
        setState(() {
          _show = true;
        });
      }
    });
    return _show ? TweenAnimationBuilder(
        tween: Tween<Offset>(begin: Offset(0, startPos), end: Offset(0, endPos)),
        duration: Duration(milliseconds: 1500),
        curve: curve,
        builder: (context, offset, child) {
          return FractionalTranslation(
            translation: offset,
            child: Container(
              width: double.infinity,
              child: child,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "Sunny",
                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white).copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "Wind: E 7 mph",
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Humidity: 91%",
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
    ) : Container();
  }
}
