// A simple model class for latitude and longitude.
class LatLng {
  final double _latitude;
  final double _longitude;

  // Constructor with validation and normalization for latitude and longitude.
  LatLng(double latitude, double longitude)
      : _latitude =
            latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude),
        _longitude = longitude >= -180 && longitude < 180
            ? longitude
            : (longitude + 180.0) % 360.0 - 180.0;

  double get latitude => _latitude;
  double get longitude => _longitude;
}
