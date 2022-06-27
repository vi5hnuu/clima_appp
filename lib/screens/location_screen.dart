import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMsg;
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMsg = '';
        cityName = 'unknown';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = WeatherModel.getWeatherIcon(condition);
      weatherMsg = WeatherModel.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/location_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop)),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData = await WeatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedName!=null){
                        var weatherData=await WeatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                      else{
                        print("object");
                      }
                    },
                    child: Icon(
                        Icons.location_city,
                        size: 50.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '${temperature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMsg != '' ? "${weatherMsg} in ${cityName}" : 'unknown',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
