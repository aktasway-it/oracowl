import 'package:astropills_tools/models/oracowl.data.dart';
import 'package:http/http.dart';

class OracowlService {
  static final OracowlService _singleton = OracowlService._internal();
  factory OracowlService() => _singleton;
  OracowlService._internal();

  OracowlData _data = OracowlData.empty();
  Future<bool> loadData(double latitude, double longitude,
      {forceReload = false}) async {
    try {
      if (!isDataLoaded() || forceReload) {
        int timeOffset = DateTime.now().timeZoneOffset.inSeconds;
        String requestURI =
            'https://api2.oracowl.io/ap/tonight?lat=$latitude&lon=$longitude&tz=$timeOffset';
        Response response = await get(Uri.parse(requestURI));
        this._data = OracowlData(response.body);
      }
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    return isDataLoaded();
  }

  Map get polaris {
    return _data.polaris;
  }

  List get tonightDSO {
    return _data.tonightDSO;
  }

  List get tonightPlanets {
    return _data.tonightPlanets;
  }

  bool isDataLoaded() {
    return this._data.loaded;
  }
}
