import 'package:flutter/material.dart';

class Feed {
  List<String> _photos = [];
  int? _userID;
  String? _caption;

  void addPhotos(String item) {
    _photos.add(item);
  }

  List<String> getPhotos() {
    return _photos;
  }
}
