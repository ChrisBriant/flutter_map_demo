
import 'package:location/location.dart';
import 'package:flutter/widgets.dart';

class LocationProvider2 with ChangeNotifier{
  Location _location = new Location();
  late LocationData _locationData;
  bool _locationLoaded = false;
  bool permissionExists =  false;
  bool serviceEnabled = false;

  Future<void> initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        print('Service is not enabled');
        return;
      } else {
        serviceEnabled = true;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      print('I should ask permission');
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Permission is not granted');
        return;
      } else {
        permissionExists = true;
      }
    }
    _locationData = await _location.getLocation();
    _locationLoaded = true;
    notifyListeners();
  }

  // initLocationTrack() {
  //   _location.onLocationChanged.listen((LocationData currentLocation) {
  //     // Use current location
  //     print('Location Changed');
  //     _locationData = currentLocation;
  //     notifyListeners();
  //   });
  // }

  LocationData get location {
    // if(!_locationLoaded) {
    //   initLocation(); 
    // }
    return _locationData;
  }

  bool get loaded {
    return _locationLoaded;
  }




}
 
