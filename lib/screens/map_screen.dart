import 'package:flutter/material.dart';
import 'package:flutter_open_google_map/models/lat_lng.dart';
import 'package:flutter_open_google_map/utils/error_handler.dart';
import 'package:flutter_open_google_map/utils/map_luancher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  LatLng? destinationLocation;

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Location';
    }
    if (value.length < 3) {
      return 'Location must have at least 3 characters';
    }
    return null;
  }

// open the map app
  Future<void> _openMap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Get destination coordinates and launch Google Maps
      destinationLocation = await MapLauncher.getDestinationCoordinates(
        _locationController.text,
      );
      if (context.mounted) {
        Navigator.of(context).pop(); // Remove loading indicator
      }
      if (destinationLocation != null) {
        await MapLauncher.openMapApp(destinationLocation);
      } else {
        // Show error message
        if (context.mounted) {
          ErrorHandler.showErrorMessage(context, 'Failed to get location.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Your Location',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // input text field to get the location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  prefixIcon: Icon(Icons.location_on_outlined),
                  labelText: 'Location',
                ),
                validator: _validateInput,
              ),

              const SizedBox(height: 40),

              // button to open google map based on given location
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    _openMap(context); // cll the openMap function
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C5230),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
