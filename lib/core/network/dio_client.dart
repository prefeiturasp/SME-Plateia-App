import 'package:dio/dio.dart';
import 'package:sme_plateia/core/utils/constants.dart';

class DioClient {
  static Future<Dio> setup() async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: BASE_URL,
    );

    final dio = Dio(options);
    dio.interceptors.addAll([
      // AuthInterceptor(dio),
      LogInterceptor(),
    ]);

    /// Print Log (production mode removal)
    // if (BuildConfig.get().flavor != Flavor.RELEASE) {
    //   dio.interceptors
    //       .add(LogInterceptor(requestBody: true, responseBody: true));
    // }
    return dio;
  }
}
