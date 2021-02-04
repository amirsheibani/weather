import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:weather/theme/theme.dart';
import 'package:weather/utils/utility.dart';
import 'package:weather/model/temp_status.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TempStatus _tempStatus;
  @override
  Widget build(BuildContext context) {
    if(_tempStatus == null){
      _tempStatus = TempStatus.defaultValue();
      getStatusWidget();
    }
    return (Device.get().isPhone) ? _smartPhoneLayout() : (Device.width > Device.height ? _tabletLandscapeLayout() : _tabletPortraitLayout());
  }

  Widget _smartPhoneLayout() {
    return  Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      // color: Theme.of(context).backgroundColor,
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: _appBar(context)
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cloudy",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedCloudy,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedCloudy = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dreary",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedDreary,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedDreary = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fog",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedFog,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedFog = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hazy",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedHazy,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedHazy = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ice",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedIce,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedIce = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mostly Cloudy",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedMostlyCloudy,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedMostlyCloudy = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mostly Cloudy Showers",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedMostlyCloudyShowers,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedMostlyCloudyShowers = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mostly Cloudy Snow",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedMostlyCloudySnow,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedMostlyCloudySnow = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mostly Cloudy Storms",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedMostlyCloudyTStorms,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedMostlyCloudyTStorms = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mostly Cloudy Clean",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedMostlySunny,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedMostlySunny = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Partly Clean",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedPartlySunny,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedPartlySunny = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Partly Clean Shower",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedPartlySunnyShower,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedPartlySunnyShower = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Partly Sunny Storms",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedPartlySunnyTStorms,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedPartlySunnyTStorms = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rain",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedRain,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedRain = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rain & Snow",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedRainSnow,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedRainSnow = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Showers",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedShowers,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedShowers = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sleet",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedSleet,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedSleet = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Snow",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedSnow,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedSnow = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sunny",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedSunny,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedSunny = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Storms",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedTStorms,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedTStorms = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Windy",style: Theme.of(context).textTheme.headline5.apply(color: ColorsBox.DayStateColor[DayState.night]),),
                          Switch(
                            value: _tempStatus.isSwitchedWindy,
                            onChanged: (value) {
                              setState(() {
                                _tempStatus = TempStatus.defaultValue();
                                _tempStatus.isSwitchedWindy = value;
                              });
                            },
                            activeTrackColor: ColorsBox.DayStateColor[DayState.afternoon],
                            activeColor: ColorsBox.DayStateColor[DayState.night],
                            inactiveTrackColor: ColorsBox.DayStateColor[DayState.morning],
                            inactiveThumbColor: ColorsBox.DayStateColor[DayState.evening],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     // color: Colors.red,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _tabletLandscapeLayout() {
    return _smartPhoneLayout();
  }

  Widget _tabletPortraitLayout() {
    return _smartPhoneLayout();
  }

  Widget _appBar(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _backToHomePage();
                    },
                    child: SizedBox(
                      height: AppBar().preferredSize.height,
                      // width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            size: 28,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          Text("Close",style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppBar().preferredSize.height,
                  width: 80,
                ),
                SizedBox(
                  height: AppBar().preferredSize.height,
                  width: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void getStatusWidget()  {
    SharedPref sharedPref = SharedPref();
    sharedPref.read("status").then((value){
      setState(() {
        _tempStatus = TempStatus.fromJson(value);
      });
    });
  }
  void _backToHomePage() {
    SharedPref sharedPref = SharedPref();
    sharedPref.save("status", _tempStatus.toJson());
    Navigator.pop(context);
  }
}