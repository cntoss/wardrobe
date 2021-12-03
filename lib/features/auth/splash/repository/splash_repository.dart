import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/constants/strings/api/apiStrings.dart'
    show AuthUrls, HomeUrls;

class SplashRepository {
  final _api = locator<ApiRepository>();
  final _authUrls = AuthUrls();
  final _homeUrls = HomeUrls();

  Future validateToken() async {
    try {
      final Response response =
          await _api.getRequest(url: _authUrls.validateToken, auth: true);
      return response.statusCode;
    } catch (e) {
      throw e;
    }
  }

  callHomeAPI() async {
    try {
      final Response response = await _api.getRequest(
        url: _homeUrls.homePage,
      );

      return response;
    } catch (e) {
      throw e;
    }
  }

  callCurrencyConversion(Map body) async {
    try {
      final Response response = await _api.postRequest(
        url: _homeUrls.currencyConversion,
        body: body
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  wishAndCart() async {
    try {
      final Response response =
          await _api.getRequest(url: _homeUrls.wishAndCart, auth: true);
      return response;
    } catch (e) {
      throw e;
    }
  }

  cartOffers() async {
    try {
      final Response response =
          await _api.getRequest(url: _homeUrls.cartOffers, auth: true);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
