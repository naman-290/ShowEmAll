import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  Future<dynamic> post(String url) async {
    String baseurl = "http://10.0.0.2:3000";
    url = baseurl + url;
    var response = await http.post(Uri.parse(url));
    var log = Logger();
    log.i(response.body);
    log.i(response.statusCode);
  }
}
