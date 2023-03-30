import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/app/app.dart';
import 'package:template/features/counter/counter.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() async {
    await configureInjector();
  });

  setUp(() => GoogleFonts.config.allowRuntimeFetching = false);
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
