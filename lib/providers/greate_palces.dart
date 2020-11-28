import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

import '../helpers/db_helper.dart';

class GreatePlaces with ChangeNotifier, DiagnosticableTreeMixin {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final Place newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: null);

    _items.add(newPlace);

    notifyListeners();

    DBelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> setPlacesFromDatabase() async {
    final data = await DBelper.getData('user_places');
    _items = data
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: null))
        .toList();

    notifyListeners();
  }
}
