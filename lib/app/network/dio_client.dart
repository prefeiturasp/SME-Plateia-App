import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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

      PrettyDioLogger(
        compact: true,
      )
    ]);

    return dio;
  }
}
