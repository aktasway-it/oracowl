import 'package:localstorage/localstorage.dart';

class StorageService {
  static final StorageService _singleton = StorageService._internal();
  factory StorageService() => _singleton;
  StorageService._internal();
  final LocalStorage _storage = new LocalStorage('oracowl.json');

  dynamic getData(String key, dynamic defaultValue) {
    try {
      dynamic value = _storage.getItem(key);
      if (value != null) {
        return value;
      } else {
        return defaultValue;
      }
    } catch(ex) {
      return defaultValue;
    }
  }

  void setData(String key, dynamic value) {
    _storage.setItem(key, value);
  }
}