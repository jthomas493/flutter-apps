import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/great_photos.dart';
import '../helpers/db_helper.dart';

class Photos with ChangeNotifier {
  List<GreatPhoto> _items = [];

  // final cloudPhotos = FirebaseFirestore.instance.collection('photos');

  List<GreatPhoto> get items {
    return [..._items];
  }

  GreatPhoto findById(String id) {
    return _items.firstWhere((photo) => photo.id == id);
  }

  Future<void> addPhoto(
    String title,
    File pickedPhoto,
  ) async {
    final newPhoto = GreatPhoto(
      id: DateTime.now().toString(),
      photo: pickedPhoto,
      title: title,
    );
    _items.add(newPhoto);
    notifyListeners();
    DBHelper.insert('photos', {
      'id': newPhoto.id,
      'title': newPhoto.title,
      'photo': newPhoto.photo.path,
    });
  }

  Future<void> fetchImages() async {
    final dataList = await DBHelper.getData('photos');
    _items = dataList
        .map(
          (item) => GreatPhoto(
            id: item['id'],
            title: item['title'],
            photo: File(item['photo']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
