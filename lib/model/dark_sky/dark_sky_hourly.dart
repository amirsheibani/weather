import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/utils/utility.dart';
import 'package:intl/intl.dart';

class DarkSkyHourly {
  double latitude;
  double longitude;
  String timezone;
  CurrentlyBean currently;
  HourlyBean hourly;
  FlagsBean flags;
  double offset;

  static Future<DarkSkyHourly> fromDarkSkyServer(String apiKey,double lat,double long) async {
    var queryParameters = {
      'units': 'ca',
      'exclude': 'daily'
    };
    var uri = Uri.https('api.darksky.net', 'forecast/$apiKey/$lat,$long', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      SharedPref sharedPref = SharedPref();
      String dataKey = 'DarkSkyHourly${DateFormat('yyyy_MM_dd').format(DateTime.now())}';
      sharedPref.save(dataKey, response.body);
      return DarkSkyHourly.fromMap(jsonDecode(response.body));
    }else{
      throw Exception('Failed to get data from server response statusCode: ${response.statusCode}');
    }
  }

  static DarkSkyHourly fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DarkSkyHourly darkSkyHourlyBean = DarkSkyHourly();
    darkSkyHourlyBean.latitude = map['latitude'];
    darkSkyHourlyBean.longitude = map['longitude'];
    darkSkyHourlyBean.timezone = map['timezone'];
    darkSkyHourlyBean.currently = CurrentlyBean.fromMap(map['currently']);
    darkSkyHourlyBean.hourly = HourlyBean.fromMap(map['hourly']);
    darkSkyHourlyBean.flags = FlagsBean.fromMap(map['flags']);
    darkSkyHourlyBean.offset = map['offset'];
    return darkSkyHourlyBean;
  }

  Map toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "timezone": timezone,
    "currently": currently,
    "hourly": hourly,
    "flags": flags,
    "offset": offset,
  };
}

class FlagsBean {
  List<String> sources;
  double nearest_station;
  String units;

  static FlagsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FlagsBean flagsBean = FlagsBean();
    flagsBean.sources = List()..addAll(
      (map['sources'] as List ?? []).map((o) => o.toString())
    );
    flagsBean.nearest_station = map['nearest-station'];
    flagsBean.units = map['units'];
    return flagsBean;
  }

  Map toJson() => {
    "sources": sources,
    "nearest-station": nearest_station,
    "units": units,
  };
}

class HourlyBean {
  String summary;
  String icon;
  List<DataBean> data;

  static HourlyBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HourlyBean hourlyBean = HourlyBean();
    hourlyBean.summary = map['summary'];
    hourlyBean.icon = map['icon'];
    hourlyBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => DataBean.fromMap(o))
    );
    return hourlyBean;
  }

  Map toJson() => {
    "summary": summary,
    "icon": icon,
    "data": data,
  };
}

class DataBean {
  int time;
  String summary;
  String icon;
  double precipIntensity;
  double precipProbability;
  String precipType;
  double temperature;
  double apparentTemperature;
  double dewPoint;
  double humidity;
  double pressure;
  double windSpeed;
  double windGust;
  double windBearing;
  double cloudCover;
  double uvIndex;
  double visibility;
  double ozone;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.time = map['time'];
    dataBean.summary = map['summary'];
    dataBean.icon = map['icon'];
    dataBean.precipIntensity = (map['precipIntensity'] is int)? map['precipIntensity'].toDouble() : map['precipIntensity'];
    dataBean.precipProbability = (map['precipProbability'] is int)? map['precipIntensity'].toDouble() :map['precipIntensity'];
    dataBean.precipType = map['precipType'];
    dataBean.temperature = (map['temperature'] is int) ?map['temperature'].toDouble() :map['temperature'];
    dataBean.apparentTemperature = (map['apparentTemperature'] is int) ?map['apparentTemperature'].toDouble() :map['apparentTemperature'];
    dataBean.dewPoint = (map['dewPoint'] is int) ?map['dewPoint'].toDouble() :map['dewPoint'];
    dataBean.humidity = (map['humidity'] is int) ?map['humidity'].toDouble() :map['humidity'];
    dataBean.pressure = (map['pressure'] is int) ?map['pressure'].toDouble() :map['pressure'];
    dataBean.windSpeed = (map['windSpeed'] is int) ?map['windSpeed'].toDouble() :map['windSpeed'];
    dataBean.windGust = (map['windGust'] is int) ?map['windGust'].toDouble() :map['windGust'];
    dataBean.windBearing = (map['windBearing'] is int) ?map['windBearing'].toDouble() :map['windBearing'];
    dataBean.cloudCover = (map['cloudCover'] is int) ?map['cloudCover'].toDouble() :map['cloudCover'];
    dataBean.uvIndex = (map['uvIndex'] is int) ?map['uvIndex'].toDouble() :map['uvIndex'];
    dataBean.visibility = (map['visibility'] is int)?map['visibility'].toDouble() :map['visibility'];
    dataBean.ozone = (map['ozone'] is int) ?map['ozone'].toDouble() :map['ozone'];
    return dataBean;
  }

  Map toJson() => {
    "time": time,
    "summary": summary,
    "icon": icon,
    "precipIntensity": precipIntensity,
    "precipProbability": precipProbability,
    "precipType": precipType,
    "temperature": temperature,
    "apparentTemperature": apparentTemperature,
    "dewPoint": dewPoint,
    "humidity": humidity,
    "pressure": pressure,
    "windSpeed": windSpeed,
    "windGust": windGust,
    "windBearing": windBearing,
    "cloudCover": cloudCover,
    "uvIndex": uvIndex,
    "visibility": visibility,
    "ozone": ozone,
  };
}

class CurrentlyBean {
  int time;
  String summary;
  String icon;
  double precipIntensity;
  double precipProbability;
  String precipType;
  double temperature;
  double apparentTemperature;
  double dewPoint;
  double humidity;
  double pressure;
  double windSpeed;
  double windGust;
  double windBearing;
  double cloudCover;
  double uvIndex;
  double visibility;
  double ozone;

  static CurrentlyBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CurrentlyBean currentlyBean = CurrentlyBean();
    currentlyBean.time = map['time'];

    currentlyBean.summary = map['summary'];
    currentlyBean.icon = map['icon'];
    currentlyBean.precipIntensity = (map['precipIntensity'] is int) ? map['precipIntensity'].toDouble() : map['precipIntensity'];
    currentlyBean.precipProbability = (map['precipProbability'] is int) ? map['precipProbability'].toDouble() : map['precipProbability'];
    currentlyBean.precipType = map['precipType'];
    currentlyBean.temperature = (map['temperature'] is int) ? map['temperature'].toDouble() : map['temperature'];
    currentlyBean.apparentTemperature = (map['apparentTemperature'] is int) ? map['apparentTemperature'].toDouble() : map['apparentTemperature'];
    currentlyBean.dewPoint = (map['dewPoint'] is int) ? map['dewPoint'].toDouble() : map['dewPoint'];
    currentlyBean.humidity = (map['humidity'] is int) ? map['humidity'].toDouble() : map['humidity'];
    currentlyBean.pressure = (map['pressure'] is int) ? map['pressure'].toDouble() : map['pressure'];
    currentlyBean.windSpeed = (map['windSpeed'] is int) ? map['windSpeed'].toDouble() : map['windSpeed'];
    currentlyBean.windGust = (map['windGust'] is int) ? map['windGust'].toDouble() : map['windGust'];
    currentlyBean.windBearing = (map['windBearing'] is int) ? map['windBearing'].toDouble() : map['windBearing'];
    currentlyBean.cloudCover = (map['cloudCover'] is int) ? map['cloudCover'].toDouble() : map['cloudCover'];
    currentlyBean.uvIndex = (map['uvIndex'] is int) ? map['uvIndex'].toDouble() : map['uvIndex'];
    currentlyBean.visibility = (map['visibility'] is int) ? map['visibility'].toDouble() : map['visibility'] ;
    currentlyBean.ozone = (map['ozone'] is int) ? map['ozone'].toDouble() : map['ozone'];
    return currentlyBean;
  }

  Map toJson() => {
    "time": time,
    "summary": summary,
    "icon": icon,
    "precipIntensity": precipIntensity,
    "precipProbability": precipProbability,
    "precipType": precipType,
    "temperature": temperature,
    "apparentTemperature": apparentTemperature,
    "dewPoint": dewPoint,
    "humidity": humidity,
    "pressure": pressure,
    "windSpeed": windSpeed,
    "windGust": windGust,
    "windBearing": windBearing,
    "cloudCover": cloudCover,
    "uvIndex": uvIndex,
    "visibility": visibility,
    "ozone": ozone,
  };
}