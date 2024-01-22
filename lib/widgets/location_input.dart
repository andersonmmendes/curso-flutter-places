import 'package:curso_flutter_places/screens/map_screen.dart';
import 'package:curso_flutter_places/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInput({
    super.key,
    required this.onSelectPosition,
  });

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double latitude, double longitude) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewIamge(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);

      widget.onSelectPosition(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(),
      ),
    );

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: Text(
                'Localização Atual',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: _getCurrentUserLocation,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: Text(
                'Selecione',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: _selectOnMap,
            )
          ],
        )
      ],
    );
  }
}
