// ignore_for_file: prefer_const_constructors

import 'package:cms/app.dart';
import 'package:cms/contents/contents.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders ContentsPage', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();
      expect(find.byType(ContentsPage), findsOneWidget);
    });
  });
}
