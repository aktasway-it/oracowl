import 'dart:convert';

class OracowlData {
  Map _data = Map();
  OracowlData.empty();

  OracowlData(String json) {
    _data = jsonDecode(json);
  }

  Map get polaris {
    return _data['polaris'];
  }

  List get tonight {
    _data['dso'].sort((a, b) => a['magnitude'] <= b['magnitude']);
    return _data['dso'].sublist(0, 3);
  }

  bool get loaded {
    return _data.isNotEmpty;
  }
}