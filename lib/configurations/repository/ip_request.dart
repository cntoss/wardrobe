import 'package:dio/dio.dart';

class IpRequest {
 Future<String?> getIp() async {
    try {
      const url = 'https://api.ipify.org';
      final Response response = await Dio().get(
        url,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

}
