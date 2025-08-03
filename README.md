# AnimatedCycler

[![pub package](https://img.shields.io/pub/v/animated_cycler.svg)](https://pub.dev/packages/animated_cycler)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev)

A versatile Flutter widget that automatically cycles through a list of items with smooth animations. Perfect for creating rolling tickers, rotating banners, news feeds, and any content that needs to be displayed in a cycling manner.

## ✨ Features

- **Bidirectional Support**: Both vertical and horizontal animation directions
- **Generic Type Safe**: Works with any data type using Dart generics
- **Smooth Animations**: Customizable animation curves and durations
- **Auto-play Control**: Start, stop, pause, and resume functionality
- **Manual Navigation**: Programmatically navigate to next, previous, or specific items
- **Flexible Styling**: Complete control over item appearance through custom builders
- **Performance Optimized**: Efficient rendering with minimal widget rebuilds
- **Easy Integration**: Simple API with sensible defaults

## 🚀 Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_cycler: ^1.0.0
```

Then run:
```bash
flutter pub get
```

### Import

```dart
import 'package:animated_cycler/animated_cycler.dart';
```

## 📱 Usage Examples

### Basic Vertical Ticker

Perfect for rankings, news headlines, or notifications:

```dart
AnimatedCycler<String>(
  direction: Axis.vertical,
  items: [
    '🥇 John - 1,250 points',
    '🥈 Sarah - 1,180 points',
    '🥉 Mike - 1,150 points',
    '4️⃣ Emma - 1,100 points',
  ],
  size: 60,
  itemBuilder: (context, item, index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        item,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.blue.shade700,
        ),
      ),
    );
  },
)
```

### Horizontal Banner Slider

Great for advertisements, promotions, or product showcases:

```dart
AnimatedCycler<Product>(
  direction: Axis.horizontal,
  items: productList,
  size: 300,
  displayDuration: Duration(seconds: 4),
  animationDuration: Duration(milliseconds: 600),
  itemBuilder: (context, product, index) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(product.imageUrl, height: 120),
          SizedBox(height: 8),
          Text(
            product.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${product.price}',
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ],
      ),
    );
  },
  onItemTap: (product, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  },
)
```

### Using Named Constructors

For cleaner code, use the direction-specific constructors:

```dart
// Vertical ticker
AnimatedCycler.vertical(
  items: notifications,
  height: 50,
  itemBuilder: (context, notification, index) {
    return NotificationTile(notification: notification);
  },
)

// Horizontal slider
AnimatedCycler.horizontal(
  items: banners,
  width: 350,
  itemBuilder: (context, banner, index) {
    return BannerCard(banner: banner);
  },
)
```

### Advanced Usage with Manual Control

```dart
class _MyPageState extends State<MyPage> {
  final GlobalKey<AnimatedCyclerState> _cyclerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCycler<String>(
          key: _cyclerKey,
          items: ['Item 1', 'Item 2', 'Item 3'],
          autoPlay: false, // Manual control
          itemBuilder: (context, item, index) {
            return Center(child: Text(item));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _cyclerKey.currentState?.previousItem(),
              child: Icon(Icons.arrow_back),
            ),
            ElevatedButton(
              onPressed: () => _cyclerKey.currentState?.togglePlayPause(),
              child: Icon(Icons.play_pause),
            ),
            ElevatedButton(
              onPressed: () => _cyclerKey.currentState?.nextItem(),
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }
}
```

## 🎛️ API Reference

### Constructor Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `items` | `List<T>` | **required** | List of items to cycle through |
| `itemBuilder` | `Widget Function(BuildContext, T, int)` | **required** | Builder function for rendering each item |
| `direction` | `Axis` | `Axis.vertical` | Animation direction (vertical/horizontal) |
| `displayDuration` | `Duration` | `3 seconds` | How long each item is displayed |
| `animationDuration` | `Duration` | `800ms` | Duration of transition animation |
| `size` | `double` | `50.0` | Widget size (height for vertical, width for horizontal) |
| `autoPlay` | `bool` | `true` | Whether to automatically cycle through items |
| `animationCurve` | `Curve` | `Curves.easeInOut` | Animation curve for transitions |
| `loop` | `bool` | `true` | Whether to loop back to first item after last |
| `onItemTap` | `Function(T, int)?` | `null` | Callback when an item is tapped |
| `onAnimationComplete` | `Function(T, int)?` | `null` | Callback when animation completes |

### Named Constructors

#### `AnimatedCycler.vertical()`
Optimized for vertical content like rankings, news feeds, notifications.

#### `AnimatedCycler.horizontal()`
Optimized for horizontal content like banners, product carousels, image sliders.

### State Methods

Access these methods through a `GlobalKey<AnimatedCyclerState>`:

| Method | Description |
|--------|-------------|
| `nextItem()` | Move to next item manually |
| `previousItem()` | Move to previous item manually |
| `goToIndex(int index)` | Jump to specific item by index |
| `togglePlayPause()` | Toggle auto-play on/off |
| `currentIndex` | Get current item index |
| `currentItem` | Get current item data |
| `isPlaying` | Check if auto-play is active |

## 🎨 Customization Examples

### Custom Animation Curves

```dart
AnimatedCycler<String>(
  items: ['Fast', 'Smooth', 'Bouncy'],
  animationCurve: Curves.bounceOut,
  animationDuration: Duration(milliseconds: 1200),
  itemBuilder: (context, item, index) {
    return Center(child: Text(item));
  },
)
```

### Different Display Durations

```dart
AnimatedCycler<String>(
  items: ['Quick', 'Normal', 'Slow'],
  displayDuration: Duration(seconds: 5), // Longer display time
  itemBuilder: (context, item, index) {
    return Center(child: Text(item));
  },
)
```

### Responsive Sizing

```dart
AnimatedCycler<String>(
  items: data,
  size: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
  direction: Axis.horizontal,
  itemBuilder: (context, item, index) {
    return ResponsiveCard(data: item);
  },
)
```

## 🧪 Testing

To test widgets that use AnimatedCycler:

```dart
testWidgets('AnimatedCycler displays items correctly', (WidgetTester tester) async {
  final items = ['Test 1', 'Test 2', 'Test 3'];
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: AnimatedCycler<String>(
          items: items,
          autoPlay: false, // Disable for testing
          itemBuilder: (context, item, index) {
            return Text(item, key: Key('item_$index'));
          },
        ),
      ),
    ),
  );

  // Verify first item is displayed
  expect(find.text('Test 1'), findsOneWidget);
  expect(find.text('Test 2'), findsNothing);
});
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/animated_cycler.git`
3. Create a feature branch: `git checkout -b feature/amazing-feature`
4. Make your changes and add tests
5. Run tests: `flutter test`
6. Commit your changes: `git commit -m 'Add amazing feature'`
7. Push to the branch: `git push origin feature/amazing-feature`
8. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by ticker displays and carousel components
- Built with ❤️ using Flutter
- Thanks to the Flutter community for feedback and suggestions

## 📞 Support

If you have any questions or issues, please:

1. Check the [example](example/) directory for usage examples
2. Search [existing issues](https://github.com/yourusername/animated_cycler/issues)
3. Create a [new issue](https://github.com/yourusername/animated_cycler/issues/new) if needed

---

⭐ If this package helped you, please give it a star on [GitHub](https://github.com/yourusername/animated_cycler) and a like on [pub.dev](https://pub.dev/packages/animated_cycler)!