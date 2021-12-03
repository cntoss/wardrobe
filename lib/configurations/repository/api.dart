import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';

import '../../global/constants/strings/api/apiParams.dart';
import '../../global/models/error/errorModel.dart';
import '../serviceLocator/locator.dart';
import 'app_api_exception.dart';

export 'package:dio/dio.dart';

class ApiRepository {
  String? get token => locator<EnvironmentModel>().token;

  final _dio = Dio(
    BaseOptions(
        baseUrl: locator<EnvironmentModel>().apiUrl,
        connectTimeout: 15000,
        receiveTimeout: 12000,
        sendTimeout: 10000,
        queryParameters: {
          "apiVersion": "v3",
          "appVersion": locator<EnvironmentModel>().appVersion,
          "buildNumber": locator<EnvironmentModel>().appBuildNumber,
          "source": locator<EnvironmentModel>().platform,
          "ip": locator<EnvironmentModel>().ip
        }),
  );

  // ignore: missing_return
  postRequest({
    body,
    Map<String, dynamic>? queryParams,
    required String url,
    bool hasErrorData = false,
    bool auth = false,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParams,
        data: body,
        options: Options(
          headers: _setHeaders(
            auth: auth,
          ),
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.json,
        ),
      );
      return _responseCodeSerializer(response);
    } on DioError catch (e) {
      throw hasErrorData ? e : AppApiException.fromDioError(e);
    } catch (e) {
      throw Exception("Unknown Error occured. Please try again.");
    }
  }

  getRequest({
    Map<String, dynamic>? queryParams,
    required String url,
    bool auth = false,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: _setHeaders(
            auth: auth,
          ),
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.json,
        ),
      );
      return _responseCodeSerializer(response);
    } on DioError catch (e) {
      throw AppApiException.fromDioError(e);
    } catch (e) {
      throw Exception("Unknown Error occured. Please try again.");
    }
  }

  fileUpdateRequest(
      {body,
      Map<String, dynamic>? queryParams,
      required String url,
      bool hasErrorData = false,
      bool auth = true,
      required BehaviorSubject<double> updateController}) async {
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParams,
        data: body,
        onSendProgress: (received, total) {
          // 
          
          updateController.sink.add(received / total);
        },
        options: Options(
          headers: _setHeaders(
            auth: auth,
          ),
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.json,
        ),
      );
      return _responseCodeSerializer(response);
    } on DioError catch (e) {
      throw hasErrorData ? e : AppApiException.fromDioError(e);
    } catch (e) {
      throw Exception("Unknown Error occured. Please try again.");
    }
  }


  _responseCodeSerializer(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return response;
    } else {
      try {
        return ErrorModel.fromRawJson(response.data);
      } catch (e) {
        throw Exception("Unknown error occured. Please try again.");
      }
    }
  }

  Map<String, dynamic> _setHeaders({
    required bool auth,
  }) {
    Map<String, dynamic> header = {};
    header[HTTPHeaderKeys.accept] = ParameterContentType.json;

    if (auth) {
      header[HTTPHeaderKeys.authorization] = "Bearer $token";
    }
    return header;
  }
}
