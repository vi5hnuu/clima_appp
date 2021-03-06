import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel{
  static const _kApiKey='use your own key๐';
  static const _kOpenWeatherMapUrl='https://api.openweathermap.org/data/2.5/weather';

  static Future<dynamic> getLocationWeather() async{
    Location location=Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper=NetworkHelper(url: '${_kOpenWeatherMapUrl}?lat=${location.latitude}&lon=${location.longitude}&appid=${_kApiKey}&units=metric');
    var weatherData=await networkHelper.getData();//can be null
    return weatherData;
  }

  static Future<dynamic> getCityWeather(String cityName) async{
    NetworkHelper networkHelper=NetworkHelper(url: '${_kOpenWeatherMapUrl}?q=${cityName}&appid=${_kApiKey}&units=metric');
    var weatherData=await networkHelper.getData();
    return weatherData;
  }

  static String getWeatherIcon(int condition){
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
