import 'package:flutter_test/flutter_test.dart';

import 'package:zepto_ui_demo/main.dart';

void main() {
  testWidgets('Home screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const FreshBasketApp());

    // Verify key UI elements are present
    expect(find.text('Delivery in 9 minutes'), findsOneWidget);
    expect(find.text('Fresh Bananas'), findsOneWidget);
    expect(find.text('View Cart'), findsOneWidget);
  });
}
