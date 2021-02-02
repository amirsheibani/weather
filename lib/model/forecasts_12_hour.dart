

class Forecasts12Hour {
  String DateTime;
  int EpochDateTime;
  int WeatherIcon;
  String IconPhrase;
  bool HasPrecipitation;
  String PrecipitationType;
  String PrecipitationIntensity;
  bool IsDaylight;
  TemperatureBean Temperature;
  int PrecipitationProbability;
  String MobileLink;
  String Link;

  static Forecasts12Hour fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Forecasts12Hour forecasts12HourBean = Forecasts12Hour();
    forecasts12HourBean.DateTime = map['DateTime'];
    forecasts12HourBean.EpochDateTime = map['EpochDateTime'];
    forecasts12HourBean.WeatherIcon = map['WeatherIcon'];
    forecasts12HourBean.IconPhrase = map['IconPhrase'];
    forecasts12HourBean.HasPrecipitation = map['HasPrecipitation'];
    forecasts12HourBean.PrecipitationType = map['PrecipitationType'];
    forecasts12HourBean.PrecipitationIntensity = map['PrecipitationIntensity'];
    forecasts12HourBean.IsDaylight = map['IsDaylight'];
    forecasts12HourBean.Temperature = TemperatureBean.fromMap(map['Temperature']);
    forecasts12HourBean.PrecipitationProbability = map['PrecipitationProbability'];
    forecasts12HourBean.MobileLink = map['MobileLink'];
    forecasts12HourBean.Link = map['Link'];
    return forecasts12HourBean;
  }

  Map toJson() => {
    "DateTime": DateTime,
    "EpochDateTime": EpochDateTime,
    "WeatherIcon": WeatherIcon,
    "IconPhrase": IconPhrase,
    "HasPrecipitation": HasPrecipitation,
    "PrecipitationType": PrecipitationType,
    "PrecipitationIntensity": PrecipitationIntensity,
    "IsDaylight": IsDaylight,
    "Temperature": Temperature,
    "PrecipitationProbability": PrecipitationProbability,
    "MobileLink": MobileLink,
    "Link": Link,
  };
}


class TemperatureBean {
  int Value;
  String Unit;
  int UnitType;

  static TemperatureBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TemperatureBean temperatureBean = TemperatureBean();
    temperatureBean.Value = map['Value'];
    temperatureBean.Unit = map['Unit'];
    temperatureBean.UnitType = map['UnitType'];
    return temperatureBean;
  }

  Map toJson() => {
    "Value": Value,
    "Unit": Unit,
    "UnitType": UnitType,
  };
}