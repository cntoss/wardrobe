import 'package:location/location.dart';

class LocationHelper {
  Location location = new Location();
  Future<LocationData?> getLocation() async {
    bool _serviceEnabled;
    late PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled != true) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }
}
