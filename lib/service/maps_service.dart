import 'package:flutter/cupertino.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

String finalAddress = "Searching Address .... ";
late Position position;

class GenerateMaps extends ChangeNotifier {
  Future getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lastPosition = await Geolocator.getLastKnownPosition();
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: position.latitude,
          longitude: position.longitude,
          googleMapApiKey: 'AIzaSyB1QciJZOZd8sTxIoY2MJ8fqA6f49jJHgA');
      String mainAddress = data.address;
      print(mainAddress);
      finalAddress = mainAddress;
      return position;
    }
  }

  void setMarker() {
    Set<Marker> _markers = Set<Marker>();
    _markers.add(
      Marker(
          markerId: MarkerId(position.latitude.toString()),
          position: LatLng(position.latitude, position.longitude)),
    );
    notifyListeners();
  }
}
