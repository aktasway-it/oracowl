import 'dart:convert';

class OracowlData {
  List _data = [];
  OracowlData.empty();

  OracowlData(String json) {
    _data = jsonDecode(json);
  }

  List get tonight {
    _data.shuffle();
    return _data.sublist(0, 3);
  }

  bool get loaded {
    return _data.isNotEmpty;
  }
}