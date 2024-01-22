import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

const googleApiKey = 'AIzaSyBqAJW7TR729GTeqAJrWYhTuv2XhpiA1_8';

class LocationUtil {
  static String generateLocationPreviewIamge({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey';
    final response = await get(Uri.parse(url));

    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
