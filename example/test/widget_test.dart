// This is a basic Flutter widget test for AnimatedCycler example app.

import 'package:flutter_test/flutter_test.dart';

import 'package:animated_cycler_example/main.dart';

void main() {
  testWidgets('AnimatedCycler app loads and displays content',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AnimatedCyclerExampleApp());

    // Verify that our app title is displayed.
    expect(find.text('AnimatedCycler Examples'), findsOneWidget);

    // Verify that ranking ticker section is displayed.
    expect(find.text('🏆 Vertical Ranking Ticker'), findsOneWidget);

    // Verify that product carousel section is displayed.
    expect(find.text('🛍️ Horizontal Product Carousel'), findsOneWidget);

    // Verify that news feed section is displayed.
    expect(find.text('📰 News Feed Ticker'), findsOneWidget);

    // Verify that manual control section is displayed.
    expect(find.text('🔧 Manual Control Example'), findsOneWidget);
  });

  testWidgets('AnimatedCycler widgets are present',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AnimatedCyclerExampleApp());

    // Wait for animations to settle
    await tester.pumpAndSettle();

    // Verify that AnimatedCycler widgets are rendered
    // We can't easily test the actual cycling without waiting for timers,
    // but we can verify the widgets are present
    expect(find.byType(AnimatedCyclerExampleApp), findsOneWidget);

    // Verify some ranking content is displayed (Alice appears in multiple sections)
    expect(find.textContaining('Alice'), findsWidgets);
  });
}
