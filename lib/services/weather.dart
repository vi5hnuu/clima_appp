import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel{
  static const _kApiKey='use your own key😁';
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
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
