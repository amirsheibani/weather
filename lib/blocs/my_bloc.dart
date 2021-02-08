import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:weather/blocs/bloc_provider.dart';
import 'package:weather/event/event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/model/dark_sky/dark_sky_hourly.dart';
import 'package:weather/model/forecasts_12_hour.dart';
import 'package:weather/model/location_key.dart';
import 'package:weather/utils/utility.dart';
import 'package:intl/intl.dart';

String apiKeyAccuweather= 'ZSLlPhNCKfflw1RgbYadbZBHAc8aZ9Pc';
String apiKeyDarkSky= 'a32bb373e104604053655e78e359a11b';

class WeatherBloc implements BlocBase {
  final _forecastLocationKeyController = BehaviorSubject<LocationKey>();
  final _forecastForecasts12HourController = BehaviorSubject<List<Forecasts12Hour>>();
  final _forecastDarkSkyHourlyController = BehaviorSubject<DarkSkyHourly>();

  StreamSink<DarkSkyHourly> get _inForecastDarkSkyHourlyControllerSink => _forecastDarkSkyHourlyController.sink;
  Stream<DarkSkyHourly> get forecastDarkSkyHourlyControllerStream => _forecastDarkSkyHourlyController.stream;

  StreamSink<LocationKey> get _inForecastLocationKeyControllerSink => _forecastLocationKeyController.sink;
  Stream<LocationKey> get forecastLocationKeyControllerStream => _forecastLocationKeyController.stream;

  StreamSink<List<Forecasts12Hour>> get _inForecastForecasts12HourControllerSink => _forecastForecasts12HourController.sink;
  Stream<List<Forecasts12Hour>> get forecastForecasts12HourControllerStream => _forecastForecasts12HourController.stream;

  final _eventController = BehaviorSubject<Event>();
  Sink<Event> get eventSink => _eventController.sink;

  WeatherBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(Event event) async {
    if (event is EventGetForecastAccuweather) {
      SharedPref sharedPref = SharedPref();
      String dataKey = 'Forecasts12Hour_${DateFormat('yyyy_MM_dd').format(DateTime.now())}';
      sharedPref.read(dataKey).then((value){
        if(value != null){
          List<Forecasts12Hour> forecasts12HourList = List();
          jsonDecode(value).map((i){
            forecasts12HourList.add(Forecasts12Hour.fromMap(i));
          }).toList();
          _inForecastForecasts12HourControllerSink.add(forecasts12HourList);
        }else{
          Forecasts12Hour.fromAccuweatherServer(event.locationKey, apiKeyAccuweather).then((value){
            _inForecastForecasts12HourControllerSink.add(value);
          });
        }
      });
    }else if(event is EventGetLocationKeyAccuweather){
      SharedPref sharedPref = SharedPref();
      String dataKey = 'LocationKey_${DateFormat('yyyy_MM_dd').format(DateTime.now())}';
      sharedPref.read(dataKey).then((value){
        if(value != null){
          _inForecastLocationKeyControllerSink.add(LocationKey.fromMap(jsonDecode(value)));
        }else{
          LocationKey.fromAccuweatherServer(35.4121,51.2320, apiKeyAccuweather).then((value){
            _inForecastLocationKeyControllerSink.add(value);
          });
        }
      });
    }else if(event is EventGetDarkSkyHourly){
      DarkSkyHourly.fromDarkSkyServer(apiKeyDarkSky,35.4121,51.2320).then((value){
        _inForecastDarkSkyHourlyControllerSink.add(value);
      });

      // SharedPref sharedPref = SharedPref();
      // String dataKey = 'DarkSkyHourly_${DateFormat('yyyy_MM_dd').format(DateTime.now())}';
      // sharedPref.read(dataKey).then((value){
      //   if(value != null){
      //     _inForecastDarkSkyHourlyControllerSink.add(DarkSkyHourly.fromMap(value));
      //   }else{
      //     DarkSkyHourly.fromDarkSkyServer(apiKeyDarkSky,35.4121,51.2320).then((value){
      //       _inForecastDarkSkyHourlyControllerSink.add(value);
      //     });
      //   }
      // });
    }
  }

  @override
  void dispose() {
    _forecastLocationKeyController.close();
    _forecastForecasts12HourController.close();
    _forecastDarkSkyHourlyController.close();
    _eventController.close();
  }
}
