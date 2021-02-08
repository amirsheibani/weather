

import 'package:weather/model/forecasts_12_hour.dart';
import 'package:weather/model/location_key.dart';

abstract class Event{}

class EventGetForecastAccuweather extends Event{
  LocationKey locationKey;
  EventGetForecastAccuweather({locationKey}):this.locationKey = locationKey;
}
class EventGetLocationKeyAccuweather extends Event{
  EventGetLocationKeyAccuweather();
}

class EventGetDarkSkyHourly extends Event{
  EventGetDarkSkyHourly();
}