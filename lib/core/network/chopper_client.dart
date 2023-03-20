import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChopperClient)
class RestClient extends ChopperClient {
  RestClient()
      : super(
          baseUrl: Uri.parse(''),
          interceptors: [
            // CurlInterceptor(),
            HttpLoggingInterceptor(),
          ],
        );
}
