

import 'dart:convert';

import 'package:weather/model/location_key.dart';
import 'package:http/http.dart' as http;
import 'package:weather/utils/utility.dart';
import 'package:intl/intl.dart';

class Forecasts12Hour {
  String dateTime;
  int epochDateTime;
  int weatherIcon;
  String iconPhrase;
  bool hasPrecipitation;
  String precipitationType;
  String precipitationIntensity;
  bool isDaylight;
  TemperatureBean temperature;
  int precipitationProbability;
  String mobileLink;
  String link;

  static Future<List<Forecasts12Hour>> fromAccuweatherServer(LocationKey locationKey,String apiKey) async {
    var queryParameters = {
      'apikey': apiKey,
    };
    var uri = Uri.http('dataservice.accuweather.com', 'forecasts/v1/hourly/12hour/${locationKey.key}', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      SharedPref sharedPref = SharedPref();
      String dataKey = 'Forecasts12Hour_${DateFormat('yyyy_MM_dd').format(DateTime.now())}';
      sharedPref.save(dataKey, response.body);
      List<Forecasts12Hour> forecasts12HourList = List();
      jsonDecode(response.body).map((i){
        forecasts12HourList.add(Forecasts12Hour.fromMap(i));
      }).toList();
      return forecasts12HourList;
    }else{
      throw Exception('Failed to get data from server response statusCode: ${response.statusCode}');
    }
  }

  static Forecasts12Hour fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Forecasts12Hour forecasts12HourBean = Forecasts12Hour();
    forecasts12HourBean.dateTime = map['DateTime'];
    forecasts12HourBean.epochDateTime = map['EpochDateTime'];
    forecasts12HourBean.weatherIcon = map['WeatherIcon'];
    forecasts12HourBean.iconPhrase = map['IconPhrase'];
    forecasts12HourBean.hasPrecipitation = map['HasPrecipitation'];
    forecasts12HourBean.precipitationType = map['PrecipitationType'];
    forecasts12HourBean.precipitationIntensity = map['PrecipitationIntensity'];
    forecasts12HourBean.isDaylight = map['IsDaylight'];
    forecasts12HourBean.temperature = TemperatureBean.fromMap(map['Temperature']);
    forecasts12HourBean.precipitationProbability = map['PrecipitationProbability'];
    forecasts12HourBean.mobileLink = map['MobileLink'];
    forecasts12HourBean.link = map['Link'];
    return forecasts12HourBean;
  }

  Map toJson() => {
    "DateTime": DateTime,
    "EpochDateTime": epochDateTime,
    "WeatherIcon": weatherIcon,
    "IconPhrase": iconPhrase,
    "HasPrecipitation": hasPrecipitation,
    "PrecipitationType": precipitationType,
    "PrecipitationIntensity": precipitationIntensity,
    "IsDaylight": isDaylight,
    "Temperature": temperature,
    "PrecipitationProbability": precipitationProbability,
    "MobileLink": mobileLink,
    "Link": link,
  };
}


class TemperatureBean {
  double value;
  String unit;
  int unitType;

  static TemperatureBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TemperatureBean temperatureBean = TemperatureBean();
    temperatureBean.value = map['Value'];
    temperatureBean.unit = map['Unit'];
    temperatureBean.unitType = map['UnitType'];
    return temperatureBean;
  }

  Map toJson() => {
    "Value": value,
    "Unit": unit,
    "UnitType": unitType,
  };
}