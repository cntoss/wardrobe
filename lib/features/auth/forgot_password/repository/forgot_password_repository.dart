import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/constants/strings/api/apiStrings.dart' show AuthUrls;

class ForgotPasswordRepository {
  final ApiRepository _apiRepository = locator<ApiRepository>();

  forgotPassword(Map<String, dynamic> body) async {
    try {
      final Response _response = await _apiRepository.postRequest(
          url: AuthUrls().forgotPassword, body: body);
      return _response;
    } catch (e) {
      rethrow;
    }
  }
}
