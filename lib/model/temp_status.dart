import 'dart:collection';

class TempStatus{
  bool isSwitchedCloudy = false;
  bool isSwitchedDreary = false;
  bool isSwitchedFog = false;
  bool isSwitchedHazy = false;
  bool isSwitchedIce = false;
  bool isSwitchedMostlyCloudy = false;
  bool isSwitchedMostlyCloudyShowers = false;
  bool isSwitchedMostlyCloudySnow= false;
  bool isSwitchedMostlyCloudyTStorms = false;
  bool isSwitchedMostlySunny = false;
  bool isSwitchedPartlySunny = false;
  bool isSwitchedPartlySunnyShower = false;
  bool isSwitchedPartlySunnyTStorms = false;
  bool isSwitchedRain = false;
  bool isSwitchedRainSnow = false;
  bool isSwitchedShowers = false;
  bool isSwitchedSleet = false;
  bool isSwitchedSnow = false;
  bool isSwitchedSunny = true;
  bool isSwitchedTStorms = false;
  bool isSwitchedWindy = false;


  TempStatus.defaultValue():
        this.isSwitchedCloudy = false,
        this.isSwitchedDreary = false,
        this.isSwitchedFog = false,
        this.isSwitchedHazy = false,
        this.isSwitchedIce = false,
        this.isSwitchedMostlyCloudy = false,
        this.isSwitchedMostlyCloudyShowers = false,
        this.isSwitchedMostlyCloudySnow = false,
        this.isSwitchedMostlyCloudyTStorms = false,
        this.isSwitchedMostlySunny = false,
        this.isSwitchedPartlySunny = false,
        this.isSwitchedPartlySunnyShower = false,
        this.isSwitchedPartlySunnyTStorms = false,
        this.isSwitchedRain = false,
        this.isSwitchedRainSnow = false,
        this.isSwitchedShowers = false,
        this.isSwitchedSleet = false,
        this.isSwitchedSnow = false,
        this.isSwitchedSunny = false,
        this.isSwitchedTStorms = false,
        this.isSwitchedWindy = false;

  TempStatus(
      this.isSwitchedCloudy,
      this.isSwitchedDreary,
      this.isSwitchedFog,
      this.isSwitchedHazy,
      this.isSwitchedIce,
      this.isSwitchedMostlyCloudy,
      this.isSwitchedMostlyCloudyShowers,
      this.isSwitchedMostlyCloudySnow,
      this.isSwitchedMostlyCloudyTStorms,
      this.isSwitchedMostlySunny,
      this.isSwitchedPartlySunny,
      this.isSwitchedPartlySunnyShower,
      this.isSwitchedPartlySunnyTStorms,
      this.isSwitchedRain,
      this.isSwitchedRainSnow,
      this.isSwitchedShowers,
      this.isSwitchedSleet,
      this.isSwitchedSnow,
      this.isSwitchedSunny,
      this.isSwitchedTStorms,
      this.isSwitchedWindy);

  TempStatus.fromJson(Map<String, dynamic> json):
        this.isSwitchedCloudy = json['isSwitchedCloudy'],
        this.isSwitchedDreary = json['isSwitchedDreary'],
        this.isSwitchedFog = json['isSwitchedFog'],
        this.isSwitchedHazy = json['isSwitchedHazy'],
        this.isSwitchedIce = json['isSwitchedIce'],
        this.isSwitchedMostlyCloudy = json['isSwitchedMostlyCloudy'],
        this.isSwitchedMostlyCloudyShowers = json['isSwitchedMostlyCloudyShowers'],
        this.isSwitchedMostlyCloudySnow = json['isSwitchedMostlyCloudySnow'],
        this.isSwitchedMostlyCloudyTStorms = json['isSwitchedMostlyCloudyTStorms'],
        this.isSwitchedMostlySunny = json['isSwitchedMostlySunny'],
        this.isSwitchedPartlySunny = json['isSwitchedPartlySunny'],
        this.isSwitchedPartlySunnyShower = json['isSwitchedPartlySunnyShower'],
        this.isSwitchedPartlySunnyTStorms = json['isSwitchedPartlySunnyTStorms'],
        this.isSwitchedRain= json['isSwitchedRain'],
        this.isSwitchedRainSnow = json['isSwitchedRainSnow'],
        this.isSwitchedShowers = json['isSwitchedShowers'],
        this.isSwitchedSleet = json['isSwitchedSleet'],
        this.isSwitchedSnow = json['isSwitchedSnow'],
        this.isSwitchedSunny = json['isSwitchedSunny'],
        this.isSwitchedTStorms = json['isSwitchedTStorms'],
        this.isSwitchedWindy = json['isSwitchedWindy'];

  Map<String, dynamic> toJson() => {
    'isSwitchedCloudy':isSwitchedCloudy,
    'isSwitchedDreary':isSwitchedDreary,
    'isSwitchedFog':isSwitchedFog,
    'isSwitchedHazy':isSwitchedHazy,
    'isSwitchedIce':isSwitchedIce,
    'isSwitchedMostlyCloudy':isSwitchedMostlyCloudy,
    'isSwitchedMostlyCloudyShowers':isSwitchedMostlyCloudyShowers,
    'isSwitchedMostlyCloudySnow':isSwitchedMostlyCloudySnow,
    'isSwitchedMostlyCloudyTStorms':isSwitchedMostlyCloudyTStorms,
    'isSwitchedMostlySunny':isSwitchedMostlySunny,
    'isSwitchedPartlySunny':isSwitchedPartlySunny,
    'isSwitchedPartlySunnyShower':isSwitchedPartlySunnyShower,
    'isSwitchedPartlySunnyTStorms':isSwitchedPartlySunnyTStorms,
    'isSwitchedRain':isSwitchedRain,
    'isSwitchedRainSnow':isSwitchedRainSnow,
    'isSwitchedShowers':isSwitchedShowers,
    'isSwitchedSleet':isSwitchedSleet,
    'isSwitchedSnow':isSwitchedSnow,
    'isSwitchedSunny':isSwitchedSunny,
    'isSwitchedTStorms':isSwitchedTStorms,
    'isSwitchedWindy':isSwitchedWindy,
  };
}