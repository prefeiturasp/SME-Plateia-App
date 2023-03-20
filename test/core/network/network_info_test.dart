import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sme_plateia/core/network/network_info.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([
  InternetConnectionCheckerPlus,
])
void main() {
  late NetworkInfo networkInfo;
  late MockInternetConnectionCheckerPlus mockInternetConnectionCheckerPlus;

  setUp(() {
    mockInternetConnectionCheckerPlus = MockInternetConnectionCheckerPlus();
    networkInfo = NetworkInfo(mockInternetConnectionCheckerPlus);
  });

  group('isConnected', () {
    test('deve redirecionar a chamada para internetConnectionCheckerPlus.hasConnection', () async {
      //Arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockInternetConnectionCheckerPlus.hasConnection).thenAnswer((_) => tHasConnectionFuture);
      //Act
      final result = networkInfo.isConnected;
      //Assert
      verify(mockInternetConnectionCheckerPlus.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
