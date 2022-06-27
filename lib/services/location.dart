
import 'package:geolocator/geolocator.dart';

class Location{
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async{
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      if(!serviceEnabled){
        return;
      }
    }
    LocationPermission perm=await Geolocator.checkPermission();
    if(perm==LocationPermission.denied){
      perm=await Geolocator.requestPermission();
      if(perm==LocationPermission.denied)
        return;
    }
    if(perm==LocationPermission.deniedForever)
      return;
    Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    this.latitude=position.latitude;
    this.longitude=position.longitude;
  }
}