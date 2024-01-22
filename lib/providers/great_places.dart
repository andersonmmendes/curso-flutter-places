import 'dart:io';
import 'dart:math';

import 'package:curso_flutter_places/models/place.dart';
import 'package:curso_flutter_places/utils/db.dart';
import 'package:curso_flutter_places/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DB.getData('places');

    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['lat'],
              longitude: item['lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);

    DB.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    notifyListeners();
  }
}
