import 'package:weather/blocs/my_bloc.dart';
import 'package:weather/event/event.dart';
import 'package:weather/model/dark_sky/dark_sky_hourly.dart';
import 'package:weather/model/forecasts_12_hour.dart';
import 'package:weather/model/location_key.dart';
import 'package:weather/model/temp_status.dart';
import 'package:weather/pages/custom/cloudy.dart';
import 'package:weather/pages/custom/day_state_information_widget.dart';
import 'package:weather/pages/custom/dreary.dart';
import 'package:weather/pages/custom/fog.dart';
import 'package:weather/pages/custom/hazy.dart';
import 'package:weather/pages/custom/ice.dart';
import 'package:weather/pages/custom/mostly_cloudy.dart';
import 'package:weather/pages/custom/mostly_cloudy_showers.dart';
import 'package:weather/pages/custom/mostly_cloudy_snow.dart';
import 'package:weather/pages/custom/mostly_cloudy_t_storms.dart';
import 'package:weather/pages/custom/mostly_sunny.dart';
import 'package:weather/pages/custom/partly_sunny.dart';
import 'package:weather/pages/custom/partly_sunny_showers.dart';
import 'package:weather/pages/custom/partly_sunny_t_storms.dart';
import 'package:weather/pages/custom/rain.dart';
import 'package:weather/pages/custom/rain_snow.dart';
import 'package:weather/pages/custom/showers.dart';
import 'package:weather/pages/custom/sleet.dart';
import 'package:weather/pages/custom/sunny.dart';
import 'package:weather/pages/custom/t_storms.dart';
import 'package:weather/pages/custom/windy.dart';
import 'package:weather/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:weather/theme/theme.dart';
import 'package:weather/utils/utility.dart';
import 'custom/snow.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherBloc _weatherBloc = WeatherBloc();
  Stream _locationKeyPreviousStream;
  Stream _forecasts12HourPreviousStream;
  Stream _darkSkyHourlyPreviousStream;
  DayState _lastDayState = DayState.morning;
  double height;
  double width;
  double bottomSpace;
  double paddingTop = 0;
  Offset _positionDayStatusWidget;
  DarkSkyHourly _darkSkyHourlyData;
  List<DataBean> morningDataList = List();
  List<DataBean> afternoonDataList = List();
  List<DataBean> eveningDataList = List();
  List<DataBean> nightDataList = List();
  double sectionMorningHeight, sectionAfternoonHeight, sectionEveningHeight, sectionNightHeight, sectionSpaceHeight;
  bool isSet = false;

  Widget statusWidget = Container();

  @override
  void initState() {
    if (_weatherBloc.forecastLocationKeyControllerStream != _locationKeyPreviousStream) {
      _locationKeyPreviousStream = _weatherBloc.forecastLocationKeyControllerStream;
      _listen(_weatherBloc.forecastLocationKeyControllerStream);
    }
    if (_weatherBloc.forecastForecasts12HourControllerStream != _forecasts12HourPreviousStream) {
      _forecasts12HourPreviousStream = _weatherBloc.forecastForecasts12HourControllerStream;
      _listen(_weatherBloc.forecastForecasts12HourControllerStream);
    }
    if (_weatherBloc.forecastDarkSkyHourlyControllerStream != _darkSkyHourlyPreviousStream) {
      _darkSkyHourlyPreviousStream = _weatherBloc.forecastDarkSkyHourlyControllerStream;
      _listen(_weatherBloc.forecastDarkSkyHourlyControllerStream);
    }
    _positionDayStatusWidget = Offset(75, paddingTop);
    _weatherBloc.eventSink.add(EventGetDarkSkyHourly());


    super.initState();
  }

  void _listen(Stream<dynamic> stream) {
    if (stream is Stream<LocationKey>) {
      stream.listen((value) async {
        if (value != null) {
          _weatherBloc.eventSink.add(EventGetForecastAccuweather(locationKey: value));
        }
      });
    } else if (stream is Stream<List<Forecasts12Hour>>) {
      stream.listen((value) async {
        if (value != null) {
          print(value);
        }
      });
    } else if (stream is Stream<DarkSkyHourly>) {
      stream.listen((value) async {
        if (value != null) {
          _darkSkyHourlyData = value;
          _calculateDataDayStates();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return Device.get().isPhone ? _smartPhoneLayout(context) : (Device.width > Device.height ? _tabletLandscapeLayout(context) : _tabletPortraitLayout(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _smartPhoneLayout(BuildContext context) {

    if(!isSet){
      if (height == null) {
        height = MediaQuery.of(context).size.height - AppBar().preferredSize.height - 47;
        width = 8;
      }
      sectionMorningHeight = height / 5;
      sectionAfternoonHeight = height / 5;
      sectionEveningHeight = height / 5;
      sectionNightHeight = height / 5;
      sectionSpaceHeight = height - (sectionMorningHeight + sectionAfternoonHeight + sectionEveningHeight + sectionNightHeight);
      _calculateDayState();
      isSet = true;
    }

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
          '${morningDataList.length > 0 ? morningDataList.first.temperature.toInt() :''}',
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
          '${afternoonDataList.length > 0 ? afternoonDataList.first.temperature.toInt() :''}',
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
          '${eveningDataList.length > 0 ? eveningDataList.first.temperature.toInt() :''}',
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
          '${nightDataList.length > 0 ? nightDataList.first.temperature.toInt() :''}',
          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
        ),
      ),
    );

    if (_lastDayState == DayState.morning) {
      sectionMorningHeight += sectionSpaceHeight;
      morningInformationWidgets.add(DayStateInformationWidget(morningDataList.length > 0 ? morningDataList.first : null));
    } else if (_lastDayState == DayState.afternoon) {
      sectionAfternoonHeight += sectionSpaceHeight;
      afternoonInformationWidgets.add(DayStateInformationWidget(afternoonDataList.length > 0 ? afternoonDataList.first : null));
    } else if (_lastDayState == DayState.evening) {
      sectionEveningHeight += sectionSpaceHeight;
      eveningInformationWidgets.add(DayStateInformationWidget(eveningDataList.length > 0 ? eveningDataList.first : null));
    } else if (_lastDayState == DayState.night) {
      sectionNightHeight += sectionSpaceHeight;
      nightInformationWidgets.add(DayStateInformationWidget(nightDataList.length > 0 ? nightDataList.first : null));
    }

    getStatusWidget();

    return Scaffold(
        appBar: _appBar(context),
        body: _darkSkyHourlyData != null ? Stack(
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
                    if (_lastDayState == DayState.night) {
                      setState(() {
                        _lastDayState = DayState.morning;
                        _positionDayStatusWidget = Offset(75, paddingTop);
                      });
                    } else if (_lastDayState == DayState.evening) {
                      setState(() {
                        _lastDayState = DayState.morning;
                        _positionDayStatusWidget = Offset(75, paddingTop);
                      });
                    } else if (_lastDayState == DayState.afternoon) {
                      setState(() {
                        _lastDayState = DayState.morning;
                        _positionDayStatusWidget = Offset(75, paddingTop);
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
                    if (_lastDayState == DayState.night) {
                      setState(() {
                        _lastDayState = DayState.afternoon;
                        _positionDayStatusWidget = Offset(75, paddingTop + sectionAfternoonHeight);
                      });
                    } else if (_lastDayState == DayState.evening) {
                      setState(() {
                        _lastDayState = DayState.afternoon;
                        _positionDayStatusWidget = Offset(75, paddingTop + sectionAfternoonHeight);
                      });
                    } else if (_lastDayState == DayState.morning) {
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
                    if (_lastDayState == DayState.night) {
                      setState(() {
                        _lastDayState = DayState.evening;
                        _positionDayStatusWidget = Offset(75, paddingTop + sectionAfternoonHeight + sectionEveningHeight);
                      });
                    } else if (_lastDayState == DayState.afternoon) {
                      setState(() {
                        _lastDayState = DayState.evening;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionEveningHeight);
                      });
                    } else if (_lastDayState == DayState.morning) {
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
                    if (_lastDayState == DayState.evening) {
                      setState(() {
                        _lastDayState = DayState.night;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight);
                      });
                    } else if (_lastDayState == DayState.afternoon) {
                      setState(() {
                        _lastDayState = DayState.night;
                        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight + sectionEveningHeight);
                      });
                    } else if (_lastDayState == DayState.morning) {
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
              child: statusWidget,
              duration: Duration(milliseconds: 1000),
              top: _positionDayStatusWidget.dy,
              left: width,
            )
          ],
        ): Container(color: Theme.of(context).backgroundColor,));
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

  void _calculateDayState(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('HH');
    int currentHour = int.parse(formatter.format(now));
    if(currentHour >= 7 &&  currentHour < 10){
      _lastDayState = DayState.morning;
    }else if(currentHour >=10 && currentHour <14){
      _lastDayState = DayState.afternoon;
      setState(() {
        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionAfternoonHeight);
      });
    }else if(currentHour >=14 && currentHour <18){
      _lastDayState = DayState.evening;
      setState(() {
        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionEveningHeight + sectionAfternoonHeight);
      });
    }else if(currentHour >=18 && currentHour <=24){
      _lastDayState = DayState.night;
      setState(() {
        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight + sectionEveningHeight + sectionAfternoonHeight);
      });
    }else if(currentHour >=0 && currentHour <=6){
      _lastDayState = DayState.night;
      setState(() {
        _positionDayStatusWidget = Offset(75, _positionDayStatusWidget.dy + sectionNightHeight + sectionEveningHeight + sectionAfternoonHeight);
      });
    }
  }

  void _calculateDataDayStates() {
    if(_darkSkyHourlyData != null){
      setState(() {
        _darkSkyHourlyData.hourly.data.forEach((element) {
          DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(element.time * 1000);
          DateFormat formatter = DateFormat('HH');
          int currentHour = int.parse(formatter.format(itemDate));
          if(currentHour >= 7 &&  currentHour < 10){
            morningDataList.add(element);
          }else if(currentHour >=10 && currentHour <14){
            afternoonDataList.add(element);
          }else if(currentHour >=14 && currentHour <18){
            eveningDataList.add(element);
          }else if(currentHour >=18 && currentHour <=24){
            nightDataList.add(element);
          }else if(currentHour >=0 && currentHour <=6){
            nightDataList.add(element);
          }
        });

      });
    }
  }

  void getStatusWidget() {
    if(_lastDayState == DayState.morning){
      if(morningDataList.isNotEmpty){
        if(morningDataList.first.icon == "clear-day" || morningDataList.first.icon == "clear"){
          setState(() {
            statusWidget = ClearWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "rain"){
          setState(() {
            statusWidget = RainWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "snow"){
          setState(() {
            statusWidget = SnowWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "sleet"){
          setState(() {
            statusWidget = SleetWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "wind"){
          setState(() {
            statusWidget = WindyWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "fog"){
          setState(() {
            statusWidget = FogWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "cloudy"){
          setState(() {
            statusWidget = CloudyWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "partly-cloudy-day" || morningDataList.first.icon == "partly-cloudy-night"){
          setState(() {
            statusWidget = MostlyCloudyWidget(_lastDayState, 256, 256);
          });
        }
      }
    }
    else if(_lastDayState == DayState.afternoon){
      if(afternoonDataList.isNotEmpty){
        if(afternoonDataList.first.icon == "clear-day" || afternoonDataList.first.icon == "clear"){
          setState(() {
            statusWidget = ClearWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "rain"){
          setState(() {
            statusWidget = RainWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "snow"){
          setState(() {
            statusWidget = SnowWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "sleet"){
          setState(() {
            statusWidget = SleetWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "wind"){
          setState(() {
            statusWidget = WindyWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "fog"){
          setState(() {
            statusWidget = FogWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "cloudy"){
          setState(() {
            statusWidget = CloudyWidget(_lastDayState, 256, 256);
          });
        }else if(afternoonDataList.first.icon == "partly-cloudy-day" || morningDataList.first.icon == "partly-cloudy-night"){
          setState(() {
            statusWidget = MostlyCloudyWidget(_lastDayState, 256, 256);
          });
        }
      }
    }
    else if(_lastDayState == DayState.evening){
      if(eveningDataList.isNotEmpty){
        if(eveningDataList.first.icon == "clear-day" || eveningDataList.first.icon == "clear"){
          setState(() {
            statusWidget = ClearWidget(_lastDayState, 256, 256);
          });
        }else if(eveningDataList.first.icon == "rain"){
          setState(() {
            statusWidget = RainWidget(_lastDayState, 256, 256);
          });
        }else if(eveningDataList.first.icon == "snow"){
          setState(() {
            statusWidget = SnowWidget(_lastDayState, 256, 256);
          });
        }else if(eveningDataList.first.icon == "sleet"){
          setState(() {
            statusWidget = SleetWidget(_lastDayState, 256, 256);
          });
        }else if(eveningDataList.first.icon == "wind"){
          setState(() {
            statusWidget = WindyWidget(_lastDayState, 256, 256);
          });
        }else if(eveningDataList.first.icon == "fog"){
          setState(() {
            statusWidget = FogWidget(_lastDayState, 256, 256);
          });
        }else if(eveningDataList.first.icon == "cloudy"){
          setState(() {
            statusWidget = CloudyWidget(_lastDayState, 256, 256);
          });
        }else if(morningDataList.first.icon == "partly-cloudy-day" || morningDataList.first.icon == "partly-cloudy-night"){
          setState(() {
            statusWidget = MostlyCloudyWidget(_lastDayState, 256, 256);
          });
        }
      }
    }
    else if(_lastDayState == DayState.night){
      if(nightDataList.isNotEmpty){
        if(nightDataList.first.icon == "clear-night" || nightDataList.first.icon == "clear"){
          setState(() {
            statusWidget = ClearWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "rain"){
          setState(() {
            statusWidget = RainWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "snow"){
          setState(() {
            statusWidget = SnowWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "sleet"){
          setState(() {
            statusWidget = SleetWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "wind"){
          setState(() {
            statusWidget = WindyWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "fog"){
          setState(() {
            statusWidget = FogWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "cloudy"){
          setState(() {
            statusWidget = CloudyWidget(_lastDayState, 256, 256);
          });
        }else if(nightDataList.first.icon == "partly-cloudy-night" || morningDataList.first.icon == "partly-cloudy-night"){
          setState(() {
            statusWidget = MostlyCloudyWidget(_lastDayState, 256, 256);
          });
        }
      }
    }

    // SharedPref sharedPref = SharedPref();
    // sharedPref.read("status").then((value) {
    //   TempStatus status = TempStatus.fromJson(value);
    //   if (status.isSwitchedCloudy) {
    //     setState(() {
    //       statusWidget = CloudyWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedDreary) {
    //     setState(() {
    //       statusWidget = DrearyWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedFog) {
    //     setState(() {
    //       statusWidget = FogWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedIce) {
    //     setState(() {
    //       statusWidget = IceWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedMostlyCloudy) {
    //     setState(() {
    //       statusWidget = MostlyCloudyWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedMostlyCloudyShowers) {
    //     setState(() {
    //       statusWidget = MostlyCloudyShowersWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedMostlyCloudyTStorms) {
    //     setState(() {
    //       statusWidget = MostlyCloudyTStormsWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedMostlyCloudySnow) {
    //     setState(() {
    //       statusWidget = MostlyCloudySnowWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedPartlySunny) {
    //     setState(() {
    //       statusWidget = PartlySunnyWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedPartlySunnyShower) {
    //     setState(() {
    //       statusWidget = PartlySunnyShowersWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedPartlySunnyTStorms) {
    //     setState(() {
    //       statusWidget = PartlySunnyTStormsWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedRain) {
    //     setState(() {
    //       statusWidget = RainWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedRainSnow) {
    //     setState(() {
    //       statusWidget = RainSnowWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedShowers) {
    //     setState(() {
    //       statusWidget = ShowersWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedSleet) {
    //     setState(() {
    //       statusWidget = SleetWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedSnow) {
    //     setState(() {
    //       statusWidget = SnowWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedSunny) {
    //     setState(() {
    //       statusWidget = ClearWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedTStorms) {
    //     setState(() {
    //       statusWidget = TStormsWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedWindy) {
    //     setState(() {
    //       statusWidget = WindyWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedHazy) {
    //     setState(() {
    //       statusWidget = HazyWidget(_lastDayState, 256, 256);
    //     });
    //   } else if (status.isSwitchedMostlySunny) {
    //     setState(() {
    //       statusWidget = MostlySunnyWidget(_lastDayState, 256, 256);
    //     });
    //   }
    // });
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
