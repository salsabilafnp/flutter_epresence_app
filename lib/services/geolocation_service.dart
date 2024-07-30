import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocationService extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);

  GeolocationService() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (currentPosition.value!.accuracy < 50) {
      currentPosition.value;
    }
  }

  // isValidLocation - memastikan lokasi saat ini berada dalam radius yang ada di data kantor
  bool isValidLocation(
      double latitude, double longitude, double radiusInMeters) {
    if (currentPosition.value == null) {
      return false;
    }

    double distanceInMeters = Geolocator.distanceBetween(
      latitude,
      longitude,
      currentPosition.value!.latitude,
      currentPosition.value!.longitude,
    );

    return distanceInMeters <= radiusInMeters;
  }
}
