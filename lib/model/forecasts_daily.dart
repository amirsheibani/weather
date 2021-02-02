
class ForecastsDaily {
  HeadlineBean Headline;
  List<DailyForecastsBean> DailyForecasts;

  static ForecastsDaily fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ForecastsDaily forecastsDailyBean = ForecastsDaily();
    forecastsDailyBean.Headline = HeadlineBean.fromMap(map['Headline']);
    forecastsDailyBean.DailyForecasts = List()..addAll(
      (map['DailyForecasts'] as List ?? []).map((o) => DailyForecastsBean.fromMap(o))
    );
    return forecastsDailyBean;
  }

  Map toJson() => {
    "Headline": Headline,
    "DailyForecasts": DailyForecasts,
  };
}

class DailyForecastsBean {
  String Date;
  int EpochDate;
  TemperatureBean Temperature;
  DayBean Day;
  NightBean Night;
  List<String> Sources;
  String MobileLink;
  String Link;

  static DailyForecastsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DailyForecastsBean dailyForecastsBean = DailyForecastsBean();
    dailyForecastsBean.Date = map['Date'];
    dailyForecastsBean.EpochDate = map['EpochDate'];
    dailyForecastsBean.Temperature = TemperatureBean.fromMap(map['Temperature']);
    dailyForecastsBean.Day = DayBean.fromMap(map['Day']);
    dailyForecastsBean.Night = NightBean.fromMap(map['Night']);
    dailyForecastsBean.Sources = List()..addAll(
      (map['Sources'] as List ?? []).map((o) => o.toString())
    );
    dailyForecastsBean.MobileLink = map['MobileLink'];
    dailyForecastsBean.Link = map['Link'];
    return dailyForecastsBean;
  }

  Map toJson() => {
    "Date": Date,
    "EpochDate": EpochDate,
    "Temperature": Temperature,
    "Day": Day,
    "Night": Night,
    "Sources": Sources,
    "MobileLink": MobileLink,
    "Link": Link,
  };
}

class NightBean {
  int Icon;
  String IconPhrase;
  bool HasPrecipitation;

  static NightBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NightBean nightBean = NightBean();
    nightBean.Icon = map['Icon'];
    nightBean.IconPhrase = map['IconPhrase'];
    nightBean.HasPrecipitation = map['HasPrecipitation'];
    return nightBean;
  }

  Map toJson() => {
    "Icon": Icon,
    "IconPhrase": IconPhrase,
    "HasPrecipitation": HasPrecipitation,
  };
}

class DayBean {
  int Icon;
  String IconPhrase;
  bool HasPrecipitation;
  String PrecipitationType;
  String PrecipitationIntensity;

  static DayBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DayBean dayBean = DayBean();
    dayBean.Icon = map['Icon'];
    dayBean.IconPhrase = map['IconPhrase'];
    dayBean.HasPrecipitation = map['HasPrecipitation'];
    dayBean.PrecipitationType = map['PrecipitationType'];
    dayBean.PrecipitationIntensity = map['PrecipitationIntensity'];
    return dayBean;
  }

  Map toJson() => {
    "Icon": Icon,
    "IconPhrase": IconPhrase,
    "HasPrecipitation": HasPrecipitation,
    "PrecipitationType": PrecipitationType,
    "PrecipitationIntensity": PrecipitationIntensity,
  };
}

class TemperatureBean {
  MinimumBean Minimum;
  MaximumBean Maximum;

  static TemperatureBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TemperatureBean temperatureBean = TemperatureBean();
    temperatureBean.Minimum = MinimumBean.fromMap(map['Minimum']);
    temperatureBean.Maximum = MaximumBean.fromMap(map['Maximum']);
    return temperatureBean;
  }

  Map toJson() => {
    "Minimum": Minimum,
    "Maximum": Maximum,
  };
}

class MaximumBean {
  double Value;
  String Unit;
  int UnitType;

  static MaximumBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MaximumBean maximumBean = MaximumBean();
    maximumBean.Value = map['Value'];
    maximumBean.Unit = map['Unit'];
    maximumBean.UnitType = map['UnitType'];
    return maximumBean;
  }

  Map toJson() => {
    "Value": Value,
    "Unit": Unit,
    "UnitType": UnitType,
  };
}

class MinimumBean {
  double Value;
  String Unit;
  int UnitType;

  static MinimumBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MinimumBean minimumBean = MinimumBean();
    minimumBean.Value = map['Value'];
    minimumBean.Unit = map['Unit'];
    minimumBean.UnitType = map['UnitType'];
    return minimumBean;
  }

  Map toJson() => {
    "Value": Value,
    "Unit": Unit,
    "UnitType": UnitType,
  };
}

class HeadlineBean {
  String EffectiveDate;
  int EffectiveEpochDate;
  int Severity;
  String Text;
  String Category;
  String EndDate;
  int EndEpochDate;
  String MobileLink;
  String Link;

  static HeadlineBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HeadlineBean headlineBean = HeadlineBean();
    headlineBean.EffectiveDate = map['EffectiveDate'];
    headlineBean.EffectiveEpochDate = map['EffectiveEpochDate'];
    headlineBean.Severity = map['Severity'];
    headlineBean.Text = map['Text'];
    headlineBean.Category = map['Category'];
    headlineBean.EndDate = map['EndDate'];
    headlineBean.EndEpochDate = map['EndEpochDate'];
    headlineBean.MobileLink = map['MobileLink'];
    headlineBean.Link = map['Link'];
    return headlineBean;
  }

  Map toJson() => {
    "EffectiveDate": EffectiveDate,
    "EffectiveEpochDate": EffectiveEpochDate,
    "Severity": Severity,
    "Text": Text,
    "Category": Category,
    "EndDate": EndDate,
    "EndEpochDate": EndEpochDate,
    "MobileLink": MobileLink,
    "Link": Link,
  };
}