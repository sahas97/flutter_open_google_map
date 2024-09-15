import 'dart:developer';

import 'package:flutter_open_google_map/models/lat_lng.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class MapLuancher {
  MapLuancher._();

  static Future<LatLng?> getDestinationCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      }
    } catch (e) {
      log('Error getting destination coordinates: $e');
    }
    return null;
  }

  static Future<void> launchGoogleMaps(LatLng? destinationLocation) async {
    if (destinationLocation == null) {
      log('Destination location is null');
      return;
    }
    double destinationLatitude = destinationLocation.latitude;
    double destinationLongitude = destinationLocation.longitude;
    final uri = Uri(
      scheme: "google.navigation",
      queryParameters: {'q': '$destinationLatitude, $destinationLongitude'},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log('Unable to open Google Maps.');
    }
  }
}
