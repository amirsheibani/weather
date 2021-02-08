/// Version : 1
/// Key : "2155957"
/// Type : "City"
/// Rank : 85
/// LocalizedName : "Lemont"
/// EnglishName : "Lemont"
/// PrimaryPostalCode : "16851"
/// Region : {"ID":"NAM","LocalizedName":"North America","EnglishName":"North America"}
/// Country : {"ID":"US","LocalizedName":"United States","EnglishName":"United States"}
/// AdministrativeArea : {"ID":"PA","LocalizedName":"Pennsylvania","EnglishName":"Pennsylvania","Level":1,"LocalizedType":"State","EnglishType":"State","CountryID":"US"}
/// TimeZone : {"Code":"EST","Name":"America/New_York","GmtOffset":-5.0,"IsDaylightSaving":false,"NextOffsetChange":"2021-03-14T07:00:00Z"}
/// GeoPosition : {"Latitude":40.811,"Longitude":-77.818,"Elevation":{"Metric":{"Value":328.0,"Unit":"m","UnitType":5},"Imperial":{"Value":1075.0,"Unit":"ft","UnitType":0}}}
/// IsAlias : false
/// SupplementalAdminAreas : [{"Level":2,"LocalizedName":"Centre","EnglishName":"Centre"}]
/// DataSets : ["AirQualityCurrentConditions","AirQualityForecasts","Alerts","DailyAirQualityForecast","DailyPollenForecast","ForecastConfidence","FutureRadar","MinuteCast","Radar"]

class Test {
  int Version;
  String Key;
  String Type;
  int Rank;
  String LocalizedName;
  String EnglishName;
  String PrimaryPostalCode;
  RegionBean Region;
  CountryBean Country;
  AdministrativeAreaBean AdministrativeArea;
  TimeZoneBean TimeZone;
  GeoPositionBean GeoPosition;
  bool IsAlias;
  List<SupplementalAdminAreasBean> SupplementalAdminAreas;
  List<String> DataSets;

  static Test fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Test testBean = Test();
    testBean.Version = map['Version'];
    testBean.Key = map['Key'];
    testBean.Type = map['Type'];
    testBean.Rank = map['Rank'];
    testBean.LocalizedName = map['LocalizedName'];
    testBean.EnglishName = map['EnglishName'];
    testBean.PrimaryPostalCode = map['PrimaryPostalCode'];
    testBean.Region = RegionBean.fromMap(map['Region']);
    testBean.Country = CountryBean.fromMap(map['Country']);
    testBean.AdministrativeArea = AdministrativeAreaBean.fromMap(map['AdministrativeArea']);
    testBean.TimeZone = TimeZoneBean.fromMap(map['TimeZone']);
    testBean.GeoPosition = GeoPositionBean.fromMap(map['GeoPosition']);
    testBean.IsAlias = map['IsAlias'];
    testBean.SupplementalAdminAreas = List()..addAll(
      (map['SupplementalAdminAreas'] as List ?? []).map((o) => SupplementalAdminAreasBean.fromMap(o))
    );
    testBean.DataSets = List()..addAll(
      (map['DataSets'] as List ?? []).map((o) => o.toString())
    );
    return testBean;
  }

  Map toJson() => {
    "Version": Version,
    "Key": Key,
    "Type": Type,
    "Rank": Rank,
    "LocalizedName": LocalizedName,
    "EnglishName": EnglishName,
    "PrimaryPostalCode": PrimaryPostalCode,
    "Region": Region,
    "Country": Country,
    "AdministrativeArea": AdministrativeArea,
    "TimeZone": TimeZone,
    "GeoPosition": GeoPosition,
    "IsAlias": IsAlias,
    "SupplementalAdminAreas": SupplementalAdminAreas,
    "DataSets": DataSets,
  };
}

/// Level : 2
/// LocalizedName : "Centre"
/// EnglishName : "Centre"

class SupplementalAdminAreasBean {
  int Level;
  String LocalizedName;
  String EnglishName;

  static SupplementalAdminAreasBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SupplementalAdminAreasBean supplementalAdminAreasBean = SupplementalAdminAreasBean();
    supplementalAdminAreasBean.Level = map['Level'];
    supplementalAdminAreasBean.LocalizedName = map['LocalizedName'];
    supplementalAdminAreasBean.EnglishName = map['EnglishName'];
    return supplementalAdminAreasBean;
  }

  Map toJson() => {
    "Level": Level,
    "LocalizedName": LocalizedName,
    "EnglishName": EnglishName,
  };
}

/// Latitude : 40.811
/// Longitude : -77.818
/// Elevation : {"Metric":{"Value":328.0,"Unit":"m","UnitType":5},"Imperial":{"Value":1075.0,"Unit":"ft","UnitType":0}}

class GeoPositionBean {
  double Latitude;
  double Longitude;
  ElevationBean Elevation;

  static GeoPositionBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GeoPositionBean geoPositionBean = GeoPositionBean();
    geoPositionBean.Latitude = map['Latitude'];
    geoPositionBean.Longitude = map['Longitude'];
    geoPositionBean.Elevation = ElevationBean.fromMap(map['Elevation']);
    return geoPositionBean;
  }

  Map toJson() => {
    "Latitude": Latitude,
    "Longitude": Longitude,
    "Elevation": Elevation,
  };
}

/// Metric : {"Value":328.0,"Unit":"m","UnitType":5}
/// Imperial : {"Value":1075.0,"Unit":"ft","UnitType":0}

class ElevationBean {
  MetricBean Metric;
  ImperialBean Imperial;

  static ElevationBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ElevationBean elevationBean = ElevationBean();
    elevationBean.Metric = MetricBean.fromMap(map['Metric']);
    elevationBean.Imperial = ImperialBean.fromMap(map['Imperial']);
    return elevationBean;
  }

  Map toJson() => {
    "Metric": Metric,
    "Imperial": Imperial,
  };
}

/// Value : 1075.0
/// Unit : "ft"
/// UnitType : 0

class ImperialBean {
  double Value;
  String Unit;
  int UnitType;

  static ImperialBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ImperialBean imperialBean = ImperialBean();
    imperialBean.Value = map['Value'];
    imperialBean.Unit = map['Unit'];
    imperialBean.UnitType = map['UnitType'];
    return imperialBean;
  }

  Map toJson() => {
    "Value": Value,
    "Unit": Unit,
    "UnitType": UnitType,
  };
}

/// Value : 328.0
/// Unit : "m"
/// UnitType : 5

class MetricBean {
  double Value;
  String Unit;
  int UnitType;

  static MetricBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MetricBean metricBean = MetricBean();
    metricBean.Value = map['Value'];
    metricBean.Unit = map['Unit'];
    metricBean.UnitType = map['UnitType'];
    return metricBean;
  }

  Map toJson() => {
    "Value": Value,
    "Unit": Unit,
    "UnitType": UnitType,
  };
}

/// Code : "EST"
/// Name : "America/New_York"
/// GmtOffset : -5.0
/// IsDaylightSaving : false
/// NextOffsetChange : "2021-03-14T07:00:00Z"

class TimeZoneBean {
  String Code;
  String Name;
  double GmtOffset;
  bool IsDaylightSaving;
  String NextOffsetChange;

  static TimeZoneBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TimeZoneBean timeZoneBean = TimeZoneBean();
    timeZoneBean.Code = map['Code'];
    timeZoneBean.Name = map['Name'];
    timeZoneBean.GmtOffset = map['GmtOffset'];
    timeZoneBean.IsDaylightSaving = map['IsDaylightSaving'];
    timeZoneBean.NextOffsetChange = map['NextOffsetChange'];
    return timeZoneBean;
  }

  Map toJson() => {
    "Code": Code,
    "Name": Name,
    "GmtOffset": GmtOffset,
    "IsDaylightSaving": IsDaylightSaving,
    "NextOffsetChange": NextOffsetChange,
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
  String ID;
  String LocalizedName;
  String EnglishName;
  int Level;
  String LocalizedType;
  String EnglishType;
  String CountryID;

  static AdministrativeAreaBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AdministrativeAreaBean administrativeAreaBean = AdministrativeAreaBean();
    administrativeAreaBean.ID = map['ID'];
    administrativeAreaBean.LocalizedName = map['LocalizedName'];
    administrativeAreaBean.EnglishName = map['EnglishName'];
    administrativeAreaBean.Level = map['Level'];
    administrativeAreaBean.LocalizedType = map['LocalizedType'];
    administrativeAreaBean.EnglishType = map['EnglishType'];
    administrativeAreaBean.CountryID = map['CountryID'];
    return administrativeAreaBean;
  }

  Map toJson() => {
    "ID": ID,
    "LocalizedName": LocalizedName,
    "EnglishName": EnglishName,
    "Level": Level,
    "LocalizedType": LocalizedType,
    "EnglishType": EnglishType,
    "CountryID": CountryID,
  };
}

/// ID : "US"
/// LocalizedName : "United States"
/// EnglishName : "United States"

class CountryBean {
  String ID;
  String LocalizedName;
  String EnglishName;

  static CountryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountryBean countryBean = CountryBean();
    countryBean.ID = map['ID'];
    countryBean.LocalizedName = map['LocalizedName'];
    countryBean.EnglishName = map['EnglishName'];
    return countryBean;
  }

  Map toJson() => {
    "ID": ID,
    "LocalizedName": LocalizedName,
    "EnglishName": EnglishName,
  };
}

/// ID : "NAM"
/// LocalizedName : "North America"
/// EnglishName : "North America"

class RegionBean {
  String ID;
  String LocalizedName;
  String EnglishName;

  static RegionBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RegionBean regionBean = RegionBean();
    regionBean.ID = map['ID'];
    regionBean.LocalizedName = map['LocalizedName'];
    regionBean.EnglishName = map['EnglishName'];
    return regionBean;
  }

  Map toJson() => {
    "ID": ID,
    "LocalizedName": LocalizedName,
    "EnglishName": EnglishName,
  };
}