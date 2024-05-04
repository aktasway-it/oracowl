import 'dart:async';
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class StorageService {
  static final StorageService _singleton = StorageService._internal();
  factory StorageService() => _singleton;
  StorageService._internal();

  Future<void> init() async {
    await initLocalStorage();
  }

  dynamic getData(String key, dynamic defaultValue) {
    try {
      dynamic value = localStorage.getItem(key);
      if (value != null) {
        return json.decode(value);
      } else {
        return defaultValue;
      }
    } catch (ex) {
      return defaultValue;
    }
  }

  void setData(String key, dynamic value) {
    localStorage.setItem(key, json.encode(value));
  }
}
