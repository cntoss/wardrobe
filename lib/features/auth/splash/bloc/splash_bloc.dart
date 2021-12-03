import 'package:rxdart/subjects.dart';

import '../../../../configurations/serviceLocator/locator.dart';

import '../model/currency_conversion_model.dart';
import '../model/wish_and_cart_model.dart';
import '../repository/splash_repository.dart';

class SplashBloc {
  CurrencyConversionModel? cModel;
  final SplashRepository _splashRepository = locator<SplashRepository>();
  //final HomeBloc _homeBloc = locator<HomeBloc>();
  final EnvironmentModel _environmentModel =
      locator<EnvironmentBloc>().envModelValue;

  //*Streams for Splash Module
  final BehaviorSubject<bool> _splash = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<CurrencyConversionModel> _currencyConversion =
      BehaviorSubject<CurrencyConversionModel>();
  final BehaviorSubject<WishAndCartModel> _wishlistAndCartIds =
      BehaviorSubject<WishAndCartModel>();
  /* final BehaviorSubject<CartOfferModel> _cartOffers =
      BehaviorSubject<CartOfferModel>(); */

  //*Streams for Splash Module

  //*Getters for Streams
  Stream<bool> get splash => _splash.stream;
  Stream<WishAndCartModel> get wishAndCart => _wishlistAndCartIds.stream;
  Stream<WishAndCartModel> get cartOffers => _wishlistAndCartIds.stream;
  Stream<CurrencyConversionModel> get currencyConversionStream =>
      _currencyConversion.stream;

  //*Getters for Streams
  //*Value accessors
  bool get splashValue => _splash.value;
  CurrencyConversionModel get currencyConversion => _currencyConversion.value;
  List<int> get wishAndCartValue => _wishlistAndCartIds.valueOrNull == null
      ? []
      : _wishlistAndCartIds.value.data!.wishlist!.product as List<int>;
  // HomeApiModel get homeApi => _homeApiModel.value;
  //*Value accessors

  Future<bool> callCurrencyConversion() async {
    try {
      Map body = {"ip": _environmentModel.ip};
      final Response response =
          await _splashRepository.callCurrencyConversion(body);
      if (response.statusCode == 200) {
        cModel = CurrencyConversionModel.fromJson(response.data);
        _currencyConversion.sink.add(
          CurrencyConversionModel.fromJson(response.data),
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> tokenValidation() async {
    try {
      final response = await _splashRepository.validateToken();
      if (response == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

 /*  Future<bool> splashApiCalls() async {
    if (await _homeBloc.callHomeApi() && await callCurrencyConversion()) {
      _splash.sink.add(true);
      return true;
    } else {
      _splash.sink.add(false);
      return false;
    }
  } */

  Future<bool> wishAndCartApiCalls() async {
    if (locator<EnvironmentBloc>().envModelValue.token != null) {
      try {
        final Response response = await _splashRepository.wishAndCart();
        if (response.statusCode == 200) {
          _wishlistAndCartIds.sink
              .add(WishAndCartModel.fromJson(response.data));
          return true;
        } else {
          _wishlistAndCartIds.sink
              .add(WishAndCartModel()); //v2 null=> WishANdCartModel
          return false;
        }
      } catch (e) {
        return false;
      }
    } else
      return false;
  }

  /* Future<bool> cartOffersApiCalls() async {
    try {
      final Response response = await _splashRepository.cartOffers();
      if (response.statusCode == 200) {
        _cartOffers.sink.add(CartOfferModel.fromJson(response.data));
        return true;
      } else {
        _wishlistAndCartIds.sink.add(WishAndCartModel());
        return false;
      }
    } catch (e) {
      return false;
    }
  } */

  closeStream() async {
    _splash.close();
    _currencyConversion.close();
    _wishlistAndCartIds.close();
   // _cartOffers.close();
    // _homeApiModel.close();
  }
}
