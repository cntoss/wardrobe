import 'package:wardrobe/global/constants/helpers/logout_helper.dart';
import 'package:dio/dio.dart';

import '../../global/constants/strings/appStrings/errorStrings.dart';
import '../../global/models/error/errorModel.dart';

class AppApiException implements Exception {
  ErrorStrings error = ErrorStrings();
  ErrorModel _errorModel = ErrorModel();
  String? message;

  _responseCodeSerializer(Response response) {
    ErrorModel _error = ErrorModel.fromJson(response.data);
    if (_error.error!.code == 401 &&
        _error.error!.message ==
            'Please check your credentials and try again!') {
      LogoutHelper().loginError();
    } else if (_error.error!.code == 401) {
      LogoutHelper().logout();
    }
    return _error;
  }

  AppApiException.fromDioError(DioError dioError) {
    _errorModel.error = Error();
    switch (dioError.type) {
      case DioErrorType.cancel:
        _errorModel.error!.message = error.dioCancel;
        break;
      case DioErrorType.connectTimeout:
        _errorModel.error!.message = error.dioConnectionTimeOout;
        break;
      case DioErrorType.other:
        _errorModel.error!.message = error.dioDefault;
        break;
      case DioErrorType.receiveTimeout:
        _errorModel.error!.message = error.dioRecieveTimeout;
        break;
      case DioErrorType.response:
        _errorModel = _responseCodeSerializer(dioError.response!);
        break;
      case DioErrorType.sendTimeout:
        _errorModel.error!.message = error.dioSendTimeout;
        break;
      default:
        _errorModel.error!.message = error.unknownError;
        break;
    }
    message = _errorModel.error!.message;
  }
}
