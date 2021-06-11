import 'package:astropills_tools/models/oracowl.data.dart';
import 'package:http/http.dart';

class OracowlService {
  static final OracowlService _singleton = OracowlService._internal();
  factory OracowlService() => _singleton;
  OracowlService._internal();

  OracowlData _data = OracowlData.empty();
  Future<void> loadData(double latitude, double longitude, {forceReload = false}) async {
    if (!isDataLoaded() || forceReload) {
      String requestURI = 'https://api.oracowl.io:5000/api/mobile/tonight?lat=$latitude&lon=$longitude';
      Response response = await get(Uri.parse(requestURI));
      print(requestURI);
      print(response.body);
      this._data = OracowlData(response.body);
    }
  }

  List get tonight {
    return _data.tonight;
  }

  bool isDataLoaded() {
    return this._data.loaded;
  }
}