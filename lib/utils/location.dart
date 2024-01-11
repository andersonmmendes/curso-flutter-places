const googleApiKey = 'AIzaSyBqAJW7TR729GTeqAJrWYhTuv2XhpiA1_8';

class LocationUtil {
  static String generateLocationPreviewIamge({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }
}
