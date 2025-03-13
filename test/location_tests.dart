import 'package:test/test.dart';
import 'package:weatherapp/models/location.dart';

void main(){
  test("Test location.toString", testToString);
}

void testToString() {
  Location location = getMockLocation();
  String locationString = location.toString();
  expect(locationString.contains("city: Eugene"), true);
}





Location getMockLocation(){
  return Location(
    state: "Oregon", 
    city: "Eugene", 
    zip: "97408", 
    latitude: 12345, 
    longitude: 67890,
  );
}