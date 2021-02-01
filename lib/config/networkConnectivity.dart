import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';

class NetworkConnectivity {
  static const String NETWORK_NOT_AVAILABLE =
      "Internet connection is not available";

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}

class DateTimeConverter {
  String getDateAndTime(String rawDateAndTime) {
    var rawDate = DateTime.tryParse(rawDateAndTime);
    var formatter = DateFormat.yMMMMd('en_US');
    String formatted = formatter.format(rawDate);
    print("Date  in date formate: $formatted");

    return formatted;
  }
}
