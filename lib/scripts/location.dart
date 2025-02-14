import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class Location{
  final String? state;
  final String? city;
  final String? zip;
  final double latitude;
  final double longitude;

  Location({
    required this.state,
    required this.city,
    required this.zip,
    required this.latitude,
    required this.longitude
  });

}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/saved_locations.json');
}

Future<File> writeLocations(List<Location> locationList) async {
  final file = await _localFile;

  String locationJson = toJson(locationList);

  // Write the file
  return file.writeAsString(locationJson);
}

Future<Map<String, dynamic>> readLocations() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return fromJson(contents);
  } catch (e) {
    // If encountering an error, return 
    return {"nothing": "nothing"};
  }
}

String toJson(List<Location> locationList) {
  String json = jsonEncode(locationList);
  return json;
}
Map<String, dynamic> fromJson(String json){
  Map<String, dynamic> decoded = jsonDecode(json);
  return decoded;
}

Future<Location?> getLocationFromAddress(String rawCity, String rawState, String rawZip) async {
  // generate an address string from the city, state, zip
  String address = '$rawCity $rawState $rawZip';
  try{ 
    // use geocoding to get the latitude and longitude from the address string
    List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
    double lat = locations[0].latitude;
    double lon = locations[0].longitude;

    // use reverse geocoding to get a placemark from the latitude and longitude
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat, lon);
    String? state = placemarks[0].administrativeArea;
    String? city = placemarks[0].locality;
    String? zip = placemarks[0].postalCode;

    // return a Location object with the complete location
    return Location(city: city, state: state, zip: zip, latitude: lat, longitude: lon);
  } on geocoding.NoResultFoundException {
    // throws NoResultFoundException when geocoding fails
    return null;
  }
  
} 

Future<Location> getLocationFromGps() async {

  geolocator.Position position = await determinePosition();

  // use reverse geocoding to get a placemark from the latitude and longitude
  List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
  String? state = placemarks[0].administrativeArea;
  String? city = placemarks[0].locality;
  String? zip = placemarks[0].postalCode;

  // return a Location object with the complete location
  return Location(city: city, state: state, zip: zip, latitude: position.latitude, longitude: position.longitude);

  
} 



/// This is a helper function taken from the flutter documentation:
/// 
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<geolocator.Position> determinePosition() async {
  bool serviceEnabled;
  geolocator.LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await geolocator.Geolocator.checkPermission();
  if (permission == geolocator.LocationPermission.denied) {
    permission = await geolocator.Geolocator.requestPermission();
    if (permission == geolocator.LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == geolocator.LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await geolocator.Geolocator.getCurrentPosition();
}