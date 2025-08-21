import 'package:animated_cycler/animated_cycler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnimatedCycler Widget Tests', () {
    testWidgets('AnimatedCycler displays first item initially', (tester) async {
      final items = <String>['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              items: items,
              autoPlay: false, // Disable for testing
              itemBuilder: (context, item, index) => Text(
                item,
                key: Key('item_$index'),
              ),
            ),
          ),
        ),
      );

      // Verify first item is displayed (current item is visible)
      expect(find.text('Item 1'), findsWidgets);
      // Next item may also be in widget tree for animation purposes
      // but Item 3 should not be present initially
      expect(find.text('Item 3'), findsNothing);
    });

    testWidgets('AnimatedCycler handles empty list gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              items: const <String>[],
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Should not crash and display empty container
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('AnimatedCycler.vertical sets correct direction',
        (tester) async {
      final items = <String>['Item 1', 'Item 2'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>.vertical(
              items: items,
              height: 100,
              autoPlay: false,
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      final widget = tester.widget(find.byType(AnimatedCycler<String>))
          as AnimatedCycler<String>;
      expect(widget.direction, equals(Axis.vertical));
      expect(widget.size, equals(100.0));
    });

    testWidgets('AnimatedCycler.horizontal sets correct direction',
        (tester) async {
      final items = <String>['Item 1', 'Item 2'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>.horizontal(
              items: items,
              width: 200,
              autoPlay: false,
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      final widget = tester.widget(find.byType(AnimatedCycler<String>))
          as AnimatedCycler<String>;
      expect(widget.direction, equals(Axis.horizontal));
      expect(widget.size, equals(200.0));
    });

    testWidgets('AnimatedCycler manual control works', (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false,
              itemBuilder: (context, item, index) => Text(
                item,
                key: Key('item_$index'),
              ),
            ),
          ),
        ),
      );

      // Initially shows first item
      expect(find.text('Item 1'), findsOneWidget);
      expect(key.currentState?.currentIndex, equals(0));
      expect(key.currentState?.currentItem, equals('Item 1'));

      // Test manual next
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(key.currentState?.currentIndex, equals(1));
      expect(key.currentState?.currentItem, equals('Item 2'));

      // Test manual previous
      key.currentState?.previousItem();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(key.currentState?.currentIndex, equals(0));
      expect(key.currentState?.currentItem, equals('Item 1'));

      // Test go to specific index
      key.currentState?.goToIndex(2);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(key.currentState?.currentIndex, equals(2));
      expect(key.currentState?.currentItem, equals('Item 3'));
    });

    testWidgets('AnimatedCycler onItemTap callback works', (tester) async {
      final items = <String>['Item 1', 'Item 2', 'Item 3'];
      String? tappedItem;
      int? tappedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              items: items,
              autoPlay: false,
              onItemTap: (item, index) {
                tappedItem = item;
                tappedIndex = index;
              },
              itemBuilder: (context, item, index) => GestureDetector(
                child: Text(item, key: Key('item_$index')),
              ),
            ),
          ),
        ),
      );

      // Tap on the first item
      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(tappedItem, equals('Item 1'));
      expect(tappedIndex, equals(0));
    });

    testWidgets('AnimatedCycler respects size constraints', (tester) async {
      final items = <String>['Item 1'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: <Widget>[
                // Vertical cycler
                AnimatedCycler<String>.vertical(
                  items: items,
                  height: 80,
                  autoPlay: false,
                  itemBuilder: (context, item, index) => ColoredBox(
                    color: Colors.red,
                    child: Text(item),
                  ),
                ),
                // Horizontal cycler
                AnimatedCycler<String>.horizontal(
                  items: items,
                  width: 150,
                  autoPlay: false,
                  itemBuilder: (context, item, index) => ColoredBox(
                    color: Colors.blue,
                    child: Text(item),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Find the SizedBox containers
      final verticalContainer = find.byType(SizedBox).first;
      final horizontalContainer = find.byType(SizedBox).last;

      final verticalBox = tester.widget(verticalContainer) as SizedBox;
      final horizontalBox = tester.widget(horizontalContainer) as SizedBox;

      // Verify vertical container has correct height
      expect(verticalBox.height, equals(80.0));
      expect(verticalBox.width, isNull);

      // Verify horizontal container has correct width
      expect(horizontalBox.width, equals(150.0));
      expect(horizontalBox.height, isNull);
    });

    testWidgets('AnimatedCycler play/pause control works', (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              // Fast for testing
              displayDuration: const Duration(milliseconds: 100),
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Initially playing
      expect(key.currentState?.isPlaying, isTrue);

      // Pause
      key.currentState?.pause();
      await tester.pump();
      expect(key.currentState?.isPlaying, isFalse);

      // Resume
      key.currentState?.resume();
      await tester.pump();
      expect(key.currentState?.isPlaying, isTrue);

      // Toggle pause
      key.currentState?.togglePlayPause();
      await tester.pump();
      expect(key.currentState?.isPlaying, isFalse);

      // Toggle play
      key.currentState?.togglePlayPause();
      await tester.pump();
      expect(key.currentState?.isPlaying, isTrue);
    });
  });

  group('AnimatedCycler Edge Cases', () {
    testWidgets('AnimatedCycler handles single item', (tester) async {
      final items = <String>['Only Item'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              items: items,
              autoPlay: false,
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Single item may appear twice in animation stack
      expect(find.text('Only Item'), findsWidgets);
    });

    testWidgets('AnimatedCycler handles invalid goToIndex', (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false,
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      final initialIndex = key.currentState!.currentIndex;

      // Try invalid indices
      key.currentState?.goToIndex(-1);
      await tester.pump();
      expect(key.currentState?.currentIndex, equals(initialIndex));

      key.currentState?.goToIndex(10);
      await tester.pump();
      expect(key.currentState?.currentIndex, equals(initialIndex));
    });

    testWidgets('AnimatedCycler animation completes properly', (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];
      String? completedItem;
      int? completedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false, // Disable auto-play for controlled testing
              animationDuration: const Duration(milliseconds: 50),
              onAnimationComplete: (item, index) {
                completedItem = item;
                completedIndex = index;
              },
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Manually trigger animation
      key.currentState?.nextItem();
      await tester.pump();
      await tester
          .pump(const Duration(milliseconds: 100)); // Wait for animation

      expect(completedItem, isNotNull);
      expect(completedIndex, isNotNull);
    });

    testWidgets('AnimatedCycler onAnimationStart callback works',
        (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];
      String? startedItem;
      int? startedIndex;
      String? completedItem;
      int? completedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false,
              animationDuration: const Duration(milliseconds: 50),
              onAnimationStart: (item, index) {
                startedItem = item;
                startedIndex = index;
              },
              onAnimationComplete: (item, index) {
                completedItem = item;
                completedIndex = index;
              },
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Test nextItem
      key.currentState?.nextItem();
      await tester.pump();
      
      // Animation start should be triggered immediately
      expect(startedItem, equals('Item 2'));
      expect(startedIndex, equals(1));
      
      // Wait for animation to complete
      await tester.pump(const Duration(milliseconds: 100));
      expect(completedItem, equals('Item 2'));
      expect(completedIndex, equals(1));

      // Reset tracking variables
      startedItem = null;
      startedIndex = null;
      completedItem = null;
      completedIndex = null;

      // Test previousItem
      key.currentState?.previousItem();
      await tester.pump();
      
      // Animation start should be triggered immediately
      expect(startedItem, equals('Item 1'));
      expect(startedIndex, equals(0));
      
      // Wait for animation to complete
      await tester.pump(const Duration(milliseconds: 100));
      expect(completedItem, equals('Item 1'));
      expect(completedIndex, equals(0));

      // Reset tracking variables
      startedItem = null;
      startedIndex = null;
      completedItem = null;
      completedIndex = null;

      // Test goToIndex
      key.currentState?.goToIndex(2);
      await tester.pump();
      
      // Animation start should be triggered immediately
      expect(startedItem, equals('Item 3'));
      expect(startedIndex, equals(2));
      
      // Wait for animation to complete
      await tester.pump(const Duration(milliseconds: 100));
      expect(completedItem, equals('Item 3'));
      expect(completedIndex, equals(2));
    });
  });

  group('AnimatedCycler Loop Tests', () {
    testWidgets('AnimatedCycler with loop: false stops at last item', 
        (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false,
              loop: false,
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Start at first item
      expect(key.currentState?.currentIndex, equals(0));

      // Go to next item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(1));

      // Go to last item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(2));

      // Try to go beyond last item - should stay at last item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(2)); // Should stay at 2
    });

    testWidgets(
        'AnimatedCycler with loop: false stops at first item going backwards',
        (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false,
              loop: false,
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Start at first item
      expect(key.currentState?.currentIndex, equals(0));

      // Try to go to previous item - should stay at first item
      key.currentState?.previousItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(0)); // Should stay at 0
    });

    testWidgets('AnimatedCycler with loop: true wraps around', (tester) async {
      final key = GlobalKey<AnimatedCyclerState<String>>();
      final items = <String>['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedCycler<String>(
              key: key,
              items: items,
              autoPlay: false,
              // loop: true is the default
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );

      // Start at first item
      expect(key.currentState?.currentIndex, equals(0));

      // Go to previous item - should wrap to last item
      key.currentState?.previousItem();
      await tester.pump();
      await tester.pumpAndSettle();
      // Should wrap to last item
      expect(key.currentState?.currentIndex, equals(2));

      // Go to next item - should go to first item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(0));

      // Go to next item - should go to second item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(1));

      // Go to next item - should go to third item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      expect(key.currentState?.currentIndex, equals(2));

      // Go to next item - should wrap to first item
      key.currentState?.nextItem();
      await tester.pump();
      await tester.pumpAndSettle();
      // Should wrap to first item
      expect(key.currentState?.currentIndex, equals(0));
    });

    // Note: AutoPlay with loop: false testing requires special Timer 
    // handling. The manual control tests above already verify the 
    // loop: false logic works correctly
  });
}
