import 'package:weather/blocs/my_bloc.dart';
import 'package:weather/pages/custom/day_state_information_widget.dart';
import 'package:weather/pages/custom/sunny_widget.dart';
import 'package:weather/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:weather/theme/theme.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyBloc _myBloc = MyBloc();
  Stream _myPreviousStream;
  DayState _lastDayState = DayState.morning;
  double height;
  double width;
  double bottomSpace;
  double paddingTop = 0;
  Offset _positionDayStatusWidget;

  @override
  void initState() {
    if (_myBloc.myControllerStream != _myPreviousStream) {
      _myPreviousStream = _myBloc.myControllerStream;
      _listen(_myPreviousStream);
    }
    _positionDayStatusWidget = Offset(75, paddingTop);
    super.initState();
  }

  void _listen(Stream<dynamic> stream) {
    stream.listen((value) async {
      if (value != null) {
        if (value is int) {
          setState(() {
            print(value);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (height == null) {
      height = MediaQuery.of(context).size.height - AppBar().preferredSize.height - 47;
      width = MediaQuery.of(context).size.width / 20;
      width = 8;
    }
    return Device.get().isPhone ? _smartPhoneLayout(context) : (Device.width > Device.height ? _tabletLandscapeLayout(context) : _tabletPortraitLayout(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _smartPhoneLayout(BuildContext context) {
    double sectionMorningHeight, sectionAfternoonHeight, sectionEveningHeight, sectionNightHeight, sectionSpaceHeight;
    sectionMorningHeight = height / 5;
    sectionAfternoonHeight = height / 5;
    sectionEveningHeight = height / 5;
    sectionNightHeight = height / 5;
    sectionSpaceHeight = height - (sectionMorningHeight + sectionAfternoonHeight + sectionEveningHeight + sectionNightHeight);

    List<Widget> morningInformationWidgets = List();
    morningInformationWidgets.add(Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Text(
        "MORNING",
        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white.withOpacity(0.5)).copyWith(fontWeight: FontWeight.bold),
      ),
    ));
    morningInformationWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          "-1°",
          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
        ),
      ),
    );
    List<Widget> afternoonInformationWidgets = List();
    afternoonInformationWidgets.add(Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Text(
        "DAY",
        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white.withOpacity(0.5)).copyWith(fontWeight: FontWeight.bold),
      ),
    ));
    afternoonInformationWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          "-1°",
          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
        ),
      ),
    );
    List<Widget> eveningInformationWidgets = List();
    eveningInformationWidgets.add(Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Text(
        "EVENING",
        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white.withOpacity(0.5)).copyWith(fontWeight: FontWeight.bold),
      ),
    ));
    eveningInformationWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          "-1°",
          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
        ),
      ),
    );
    List<Widget> nightInformationWidgets = List();
    nightInformationWidgets.add(Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Text(
        "NIGHT",
        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white.withOpacity(0.5)).copyWith(fontWeight: FontWeight.bold),
      ),
    ));
    nightInformationWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          "-1°",
          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
        ),
      ),
    );

    if (_lastDayState == DayState.morning) {
      sectionMorningHeight += sectionSpaceHeight;
      morningInformationWidgets.add(DayStateInformationWidget());
    } else if (_lastDayState == DayState.afternoon) {
      sectionAfternoonHeight += sectionSpaceHeight;
      afternoonInformationWidgets.add(DayStateInformationWidget());
    } else if (_lastDayState == DayState.evening) {
      sectionEveningHeight += sectionSpaceHeight;
      eveningInformationWidgets.add(DayStateInformationWidget());
    } else if (_lastDayState == DayState.night) {
      sectionNightHeight += sectionSpaceHeight;
      nightInformationWidgets.add(DayStateInformationWidget());
    }

    return Scaffold(
        appBar: _appBar(context),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: AnimatedContainer(
                    width: double.infinity,
                    height: sectionMorningHeight,
                    decoration: BoxDecoration(
                      color: ColorsBox.DayStateColor[DayState.morning],
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: morningInformationWidgets,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if(_lastDayState == DayState.night){
                      setState(() {
                        _lastDayState = DayState.morning;
                        _positionDayStatusWidget = Offset(75,paddingTop);
                      });
                    }else if(_lastDayState == DayState.evening){
                      setState(() {
                        _lastDayState = DayState.morning;
                        _positionDayStatusWidget = Offset(75,paddingTop);
                      });
                    }else if(_lastDayState == DayState.afternoon){
                      setState(() {
                        _lastDayState = DayState.morning;
                        _positionDayStatusWidget = Offset(75,paddingTop);
                      });
                    }
                  },
                ),
                InkWell(
                  child: AnimatedContainer(
                    width: double.infinity,
                    height: sectionAfternoonHeight,
                    decoration: BoxDecoration(
                      color: ColorsBox.DayStateColor[DayState.afternoon],
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: afternoonInformationWidgets,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if(_lastDayState == DayState.night){
                      setState(() {
                        _lastDayState = DayState.afternoon;
                        _positionDayStatusWidget = Offset(75, paddingTop + sectionAfternoonHeight);
                      });
                    }else if(_lastDayState == DayState.evening){
                      setState(() {
                        _lastDayState = DayState.afternoon;
                        _positionDayStatusWidget = Offset(75, paddingTop + sectionAfternoonHeight);
                      });
                    }else if(_lastDayState == DayState.morning){
                      setState(() {
                        _lastDayState = DayState.afternoon;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionAfternoonHeight);
                      });
                    }
                  },
                ),
                InkWell(
                  child: AnimatedContainer(
                    width: double.infinity,
                    height: sectionEveningHeight,
                    decoration: BoxDecoration(
                      color: ColorsBox.DayStateColor[DayState.evening],
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: eveningInformationWidgets,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if(_lastDayState == DayState.night){
                      setState(() {
                        _lastDayState = DayState.evening;
                        _positionDayStatusWidget = Offset(75, paddingTop + sectionAfternoonHeight + sectionEveningHeight);
                      });
                    }else if(_lastDayState == DayState.afternoon){
                      setState(() {
                        _lastDayState = DayState.evening;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionEveningHeight);
                      });
                    }else if(_lastDayState == DayState.morning){
                      setState(() {
                        _lastDayState = DayState.evening;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionEveningHeight + sectionAfternoonHeight);
                      });
                    }
                  },
                ),
                InkWell(
                  child: AnimatedContainer(
                    width: double.infinity,
                    height: sectionNightHeight,
                    decoration: BoxDecoration(
                      color: ColorsBox.DayStateColor[DayState.night],
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: nightInformationWidgets,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if(_lastDayState == DayState.evening){
                      setState(() {
                        _lastDayState = DayState.night;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight);
                      });
                    }else if(_lastDayState == DayState.afternoon){
                      setState(() {
                        _lastDayState = DayState.night;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight + sectionEveningHeight);
                      });
                    }else if(_lastDayState == DayState.morning){
                      setState(() {
                        _lastDayState = DayState.night;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight + sectionEveningHeight + sectionAfternoonHeight);
                      });
                    }
                  },
                ),
              ],
            ),
            AnimatedPositioned(
              child: SunnyWidget(_lastDayState),
              duration: Duration(milliseconds: 1000),
              top: _positionDayStatusWidget.dy,
              left: width,
            )
          ],
        ));
  }



  Widget _tabletLandscapeLayout(BuildContext context) {
    return _smartPhoneLayout(context);
  }

  Widget _tabletPortraitLayout(BuildContext context) {
    return _smartPhoneLayout(context);
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      brightness: Brightness.light,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0.0,
      title: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _goToSettingPage();
                  },
                  child: SizedBox(
                    height: AppBar().preferredSize.height,
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          size: 28,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        // Text("Back",style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
              ),
              // Image.asset(Utility.getImagePathAssetsForAppBar('logo'),
              //     height: (Device.get().isPhone) ? (AppBar().preferredSize.height * 33) / 100 : (AppBar().preferredSize.height * 60) / 100, fit: BoxFit.cover),
              SizedBox(
                height: AppBar().preferredSize.height,
                width: 80,
              ),
            ],
          );
        },
      ),
    );
  }

  void _goToSettingPage() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black26,
        barrierDismissible: false,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset(0.0, 0.0);
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.only(top: height / 2),
              child: SettingPage(),
            ),
          );
        });
  }
}
