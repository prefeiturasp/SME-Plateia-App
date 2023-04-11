// import 'package:dio/dio.dart';
// import 'package:jwt_decode/jwt_decode.dart';

// enum TokenErrorType { tokenNotFound, refreshTokenHasExpired, failedToRegenerateAccessToken, invalidAccessToken }

// class AuthInterceptor extends QueuedInterceptor {
//   final Dio _dio;
//   final _localStorage = LocalStorage.instance; // helper class to access your local storage

//   AuthInterceptor(this._dio);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     if (options.headers["requiresToken"] == false) {
//       // if the request doesn't need token, then just continue to the next interceptor
//       options.headers.remove("requiresToken"); //remove the auxiliary header
//       return handler.next(options);
//     }

//     // get tokens from local storage, you can use Hive or flutter_secure_storage
//     final accessToken = _localStorage.getAccessToken();
//     final refreshToken = _localStorage.getRefreshToken();

//     if (accessToken == null || refreshToken == null) {
//       _performLogout(_dio);

//       // create custom dio error
//       options.extra["tokenErrorType"] = TokenErrorType.tokenNotFound; // I use enum type, you can chage it to string
//       final error = DioError(requestOptions: options, type: DioErrorType.unknown);
//       return handler.reject(error);
//     }

//     // check if tokens have already expired or not
//     // I use jwt_decoder package
//     // Note: ensure your tokens has "exp" claim
//     final accessTokenHasExpired = Jwt.isExpired(accessToken);
//     final refreshTokenHasExpired = Jwt.isExpired(refreshToken);

//     var _refreshed = true;

//     if (refreshTokenHasExpired) {
//       _performLogout(_dio);

//       // create custom dio error
//       options.extra["tokenErrorType"] = TokenErrorType.refreshTokenHasExpired;
//       final error = DioError(requestOptions: options, type: DioErrorType.unknown);

//       return handler.reject(error);
//     } else if (accessTokenHasExpired) {
//       // regenerate access token
//       _dio.interceptors.requestLock.lock();
//       _refreshed = await _regenerateAccessToken();
//       _dio.interceptors.requestLock.unlock();
//     }

//     if (_refreshed) {
//       // add access token to the request header
//       options.headers["Authorization"] = "Bearer $accessToken";
//       return handler.next(options);
//     } else {
//       // create custom dio error
//       options.extra["tokenErrorType"] = TokenErrorType.failedToRegenerateAccessToken;
//       final error = DioError(requestOptions: options, type: DioErrorType.unknown);
//       return handler.reject(error);
//     }
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
//       // for some reasons the token can be invalidated before it is expired by the backend.
//       // then we should navigate the user back to login page

//       _performLogout(_dio);

//       // create custom dio error
//       err.type = DioErrorType.other;
//       err.requestOptions.extra["tokenErrorType"] = TokenErrorType.invalidAccessToken;
//     }

//     return handler.next(err);
//   }

//   void _performLogout(Dio dio) {
//     _dio.interceptors.requestLock.clear();
//     _dio.interceptors.requestLock.lock();

//     _localStorage.removeTokens(); // remove token from local storage

//     // back to login page without using context
//     // check this https://stackoverflow.com/a/53397266/9101876
//     navigatorKey.currentState?.pushReplacementNamed(LoginPage.routeName);

//     _dio.interceptors.requestLock.unlock();
//   }

//   /// return true if it is successfully regenerate the access token
//   Future<bool> _regenerateAccessToken() async {
//     try {
//       var dio = Dio(); // should create new dio instance because the request interceptor is being locked

//       // get refresh token from local storage
//       final refreshToken = _localStorage.getRefreshToken();

//       // make request to server to get the new access token from server using refresh token
//       final response = await dio.post(
//         "https://yourDomain.com/api/refresh",
//         options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final newAccessToken = response.data["accessToken"]; // parse data based on your JSON structure
//         _localStorage.saveAccessToken(newAccessToken); // save to local storage
//         return true;
//       } else if (response.statusCode == 401 || response.statusCode == 403) {
//         // it means your refresh token no longer valid now, it may be revoked by the backend
//         _performLogout(_dio);
//         return false;
//       } else {
//         print(response.statusCode);
//         return false;
//       }
//     } on DioError {
//       return false;
//     } catch (e) {
//       return false;
//     }
//   }
// }

import 'package:dio/dio.dart';

// OBS: APENAS PARA TESTAR FLUXO DE REQUISIÇÃO.
class TestInterceptor extends Interceptor {
  final Dio _dio;
  TestInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var customHeaders = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgxMzEyNDg4LCJpYXQiOjE2ODEyMjYwODgsImp0aSI6ImMyOTdiYzExYWU3ZTQ2ZjNhYjE1MzY3ZDNhNGY1ZDA4IiwidXNlcl9pZCI6IjA3NDkzNDBGLTJCRTMtRTExMS1BNzkxLTAwMTU1RDAyRTcwMiJ9.LmZXhKlEc67bL5LWOgvD8lG1GK3t50TM6B0ahdH10BA'
    };
    options.headers.addAll(customHeaders);
    super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   print(
  //       'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
  //   super.onResponse(response, handler);
  // }

  // @override
  // Future onError(DioError err, ErrorInterceptorHandler handler) {
  //   print(
  //       'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
  //   super.onError(err, handler);
  // }
}
