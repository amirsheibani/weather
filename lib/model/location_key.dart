import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/utils/utility.dart';
import 'package:intl/intl.dart';


class LocationKey {
  int version;
  String key;
  String type;
  int rank;
  String localizedName;
  String englishName;
  String primaryPostalCode;
  RegionBean region;
  CountryBean country;
  AdministrativeAreaBean administrativeArea;
  TimeZoneBean timeZone;
  GeoPositionBean geoPosition;
  bool isAlias;
  List<SupplementalAdminAreasBean> supplementalAdminAreas;
  List<String> dataSets;

  static Future<LocationKey> fromAccuweatherServer(double lat,double long,String apiKey)async{
    var queryParameters = {
      'apikey': apiKey,
      'q': '$lat,$long',
    };
    var uri = Uri.http('dataservice.accuweather.com', 'locations/v1/cities/geoposition/search', queryParameters);
    // String url = 'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$apiKey&q=$lat,$long';
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      SharedPref sharedPref = SharedPref();
      String dataKey = 'LocationKey_${DateFormat('yyyy_MM_dd').format(DateTime.now())}';
      sharedPref.save(dataKey, response.body);
      return LocationKey.fromMap(jsonDecode(response.body));
    }else{
      throw Exception('Failed to get data from server response statusCode: ${response.statusCode}');
    }
  }

  static LocationKey fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LocationKey locationKeyBean = LocationKey();
    locationKeyBean.version = map['Version'];
    locationKeyBean.key = map['Key'];
    locationKeyBean.type = map['Type'];
    locationKeyBean.rank = map['Rank'];
    locationKeyBean.localizedName = map['LocalizedName'];
    locationKeyBean.englishName = map['EnglishName'];
    locationKeyBean.primaryPostalCode = map['PrimaryPostalCode'];
    locationKeyBean.region = RegionBean.fromMap(map['Region']);
    locationKeyBean.country = CountryBean.fromMap(map['Country']);
    locationKeyBean.administrativeArea = AdministrativeAreaBean.fromMap(map['AdministrativeArea']);
    locationKeyBean.timeZone = TimeZoneBean.fromMap(map['TimeZone']);
    locationKeyBean.geoPosition = GeoPositionBean.fromMap(map['GeoPosition']);
    locationKeyBean.isAlias = map['IsAlias'];
    locationKeyBean.supplementalAdminAreas = List()..addAll(
      (map['SupplementalAdminAreas'] as List ?? []).map((o) => SupplementalAdminAreasBean.fromMap(o))
    );
    locationKeyBean.dataSets = List()..addAll(
      (map['DataSets'] as List ?? []).map((o) => o.toString())
    );
    return locationKeyBean;
  }

  Map toJson() => {
    "Version": version,
    "Key": key,
    "Type": type,
    "Rank": rank,
    "LocalizedName": localizedName,
    "EnglishName": englishName,
    "PrimaryPostalCode": primaryPostalCode,
    "Region": region,
    "Country": country,
    "AdministrativeArea": administrativeArea,
    "TimeZone": timeZone,
    "GeoPosition": geoPosition,
    "IsAlias": isAlias,
    "SupplementalAdminAreas": supplementalAdminAreas,
    "DataSets": dataSets,
  };
}

/// Level : 2
/// LocalizedName : "Centre"
/// EnglishName : "Centre"

class SupplementalAdminAreasBean {
  int level;
  String localizedName;
  String englishName;

  static SupplementalAdminAreasBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SupplementalAdminAreasBean supplementalAdminAreasBean = SupplementalAdminAreasBean();
    supplementalAdminAreasBean.level = map['Level'];
    supplementalAdminAreasBean.localizedName = map['LocalizedName'];
    supplementalAdminAreasBean.englishName = map['EnglishName'];
    return supplementalAdminAreasBean;
  }

  Map toJson() => {
    "Level": level,
    "LocalizedName": localizedName,
    "EnglishName": englishName,
  };
}

/// Latitude : 40.811
/// Longitude : -77.818
/// Elevation : {"Metric":{"Value":328.0,"Unit":"m","UnitType":5},"Imperial":{"Value":1075.0,"Unit":"ft","UnitType":0}}

class GeoPositionBean {
  double latitude;
  double longitude;
  ElevationBean elevation;

  static GeoPositionBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GeoPositionBean geoPositionBean = GeoPositionBean();
    geoPositionBean.latitude = map['Latitude'];
    geoPositionBean.longitude = map['Longitude'];
    geoPositionBean.elevation = ElevationBean.fromMap(map['Elevation']);
    return geoPositionBean;
  }

  Map toJson() => {
    "Latitude": latitude,
    "Longitude": longitude,
    "Elevation": elevation,
  };
}

/// Metric : {"Value":328.0,"Unit":"m","UnitType":5}
/// Imperial : {"Value":1075.0,"Unit":"ft","UnitType":0}

class ElevationBean {
  MetricBean metric;
  ImperialBean imperial;

  static ElevationBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ElevationBean elevationBean = ElevationBean();
    elevationBean.metric = MetricBean.fromMap(map['Metric']);
    elevationBean.imperial = ImperialBean.fromMap(map['Imperial']);
    return elevationBean;
  }

  Map toJson() => {
    "Metric": metric,
    "Imperial": imperial,
  };
}

/// Value : 1075.0
/// Unit : "ft"
/// UnitType : 0

class ImperialBean {
  double value;
  String unit;
  int unitType;

  static ImperialBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ImperialBean imperialBean = ImperialBean();
    imperialBean.value = map['Value'];
    imperialBean.unit = map['Unit'];
    imperialBean.unitType = map['UnitType'];
    return imperialBean;
  }

  Map toJson() => {
    "Value": value,
    "Unit": unit,
    "UnitType": unitType,
  };
}

/// Value : 328.0
/// Unit : "m"
/// UnitType : 5

class MetricBean {
  double value;
  String unit;
  int unitType;

  static MetricBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MetricBean metricBean = MetricBean();
    metricBean.value = map['Value'];
    metricBean.unit = map['Unit'];
    metricBean.unitType = map['UnitType'];
    return metricBean;
  }

  Map toJson() => {
    "Value": value,
    "Unit": unit,
    "UnitType": unitType,
  };
}

/// Code : "EST"
/// Name : "America/New_York"
/// GmtOffset : -5.0
/// IsDaylightSaving : false
/// NextOffsetChange : "2021-03-14T07:00:00Z"

class TimeZoneBean {
  String code;
  String name;
  double gmtOffset;
  bool isDaylightSaving;
  String nextOffsetChange;

  static TimeZoneBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TimeZoneBean timeZoneBean = TimeZoneBean();
    timeZoneBean.code = map['Code'];
    timeZoneBean.name = map['Name'];
    timeZoneBean.gmtOffset = map['GmtOffset'];
    timeZoneBean.isDaylightSaving = map['IsDaylightSaving'];
    timeZoneBean.nextOffsetChange = map['NextOffsetChange'];
    return timeZoneBean;
  }

  Map toJson() => {
    "Code": code,
    "Name": name,
    "GmtOffset": gmtOffset,
    "IsDaylightSaving": isDaylightSaving,
    "NextOffsetChange": nextOffsetChange,
  };
}

/// ID : "PA"
/// LocalizedName : "Pennsylvania"
/// EnglishName : "Pennsylvania"
/// Level : 1
/// LocalizedType : "State"
/// EnglishType : "State"
/// CountryID : "US"

class AdministrativeAreaBean {
  String id;
  String localizedName;
  String englishName;
  int level;
  String localizedType;
  String englishType;
  String countryID;

  static AdministrativeAreaBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AdministrativeAreaBean administrativeAreaBean = AdministrativeAreaBean();
    administrativeAreaBean.id = map['ID'];
    administrativeAreaBean.localizedName = map['LocalizedName'];
    administrativeAreaBean.englishName = map['EnglishName'];
    administrativeAreaBean.level = map['Level'];
    administrativeAreaBean.localizedType = map['LocalizedType'];
    administrativeAreaBean.englishType = map['EnglishType'];
    administrativeAreaBean.countryID = map['CountryID'];
    return administrativeAreaBean;
  }

  Map toJson() => {
    "ID": id,
    "LocalizedName": localizedName,
    "EnglishName": englishName,
    "Level": level,
    "LocalizedType": localizedType,
    "EnglishType": englishType,
    "CountryID": countryID,
  };
}

/// ID : "US"
/// LocalizedName : "United States"
/// EnglishName : "United States"

class CountryBean {
  String id;
  String localizedName;
  String englishName;

  static CountryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountryBean countryBean = CountryBean();
    countryBean.id = map['ID'];
    countryBean.localizedName = map['LocalizedName'];
    countryBean.englishName = map['EnglishName'];
    return countryBean;
  }

  Map toJson() => {
    "ID": id,
    "LocalizedName": localizedName,
    "EnglishName": englishName,
  };
}

/// ID : "NAM"
/// LocalizedName : "North America"
/// EnglishName : "North America"

class RegionBean {
  String id;
  String localizedName;
  String englishName;

  static RegionBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RegionBean regionBean = RegionBean();
    regionBean.id = map['ID'];
    regionBean.localizedName = map['LocalizedName'];
    regionBean.englishName = map['EnglishName'];
    return regionBean;
  }

  Map toJson() => {
    "ID": id,
    "LocalizedName": localizedName,
    "EnglishName": englishName,
  };
}