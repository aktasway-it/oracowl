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

  List get tonightDSO {
    return _data['dso'];
  }

  List get tonightPlanets {
    return _data['planets'];
  }

  bool get loaded {
    return _data.isNotEmpty;
  }
}