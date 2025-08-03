# AnimatedCycler Example App

This example app demonstrates various use cases and features of the AnimatedCycler widget.

## Features Demonstrated

### 🏆 Vertical Ranking Ticker
- Shows a leaderboard that automatically cycles through rankings
- Demonstrates basic vertical animation with custom styling
- Uses container decoration with shadows and rounded corners

### 🛍️ Horizontal Product Carousel
- Displays products in a horizontal slider format
- Shows how to handle tap events with `onItemTap` callback
- Demonstrates using custom data models with the generic type system

### 📰 News Feed Ticker
- Simulates a news ticker with breaking news items
- Uses custom animation curves (`Curves.easeOutCubic`)
- Shows gradient backgrounds and custom timing

### 🔧 Manual Control Example
- Demonstrates all manual control methods:
  - `nextItem()` - advance to next item
  - `previousItem()` - go back to previous item
  - `togglePlayPause()` - start/stop auto-play
- Shows how to access current state information
- Displays current index and playing status

### 🔔 Notification Bell
- Simple notification system with icon
- Shows minimal styling approach
- Demonstrates integration with other UI elements

### ⚙️ Customization Options
- **Fast Animation**: Quick transitions with bounce effect
- **Slow & Smooth**: Longer display time with smooth transitions
- Shows different timing and curve options

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Code Structure

The example app is organized to showcase different patterns:

- **Basic Usage**: Simple vertical and horizontal examples
- **Data Models**: Using custom classes with generic types
- **Event Handling**: Tap callbacks and animation completion
- **Manual Control**: Programmatic control through state methods
- **Styling**: Various decoration and theming approaches
- **Performance**: Different timing and animation configurations

## Learning Points

### Basic Implementation
```dart
AnimatedCycler<String>.vertical(
  items: ['Item 1', 'Item 2', 'Item 3'],
  height: 60,
  itemBuilder: (context, item, index) {
    return Center(child: Text(item));
  },
)
```

### Manual Control
```dart
final key = GlobalKey<AnimatedCyclerState<String>>();

AnimatedCycler<String>(
  key: key,
  items: items,
  autoPlay: false,
  // ... other properties
)

// Control methods
key.currentState?.nextItem();
key.currentState?.previousItem();
key.currentState?.togglePlayPause();
```

### Custom Data Types
```dart
class ProductModel {
  final String name;
  final String price;
  final Color color;
  final IconData icon;
}

AnimatedCycler<ProductModel>(
  items: productList,
  itemBuilder: (context, product, index) {
    return ProductCard(product: product);
  },
)
```

### Event Handling
```dart
AnimatedCycler<String>(
  items: items,
  onItemTap: (item, index) {
    print('Tapped: $item at index $index');
  },
  onAnimationComplete: (item, index) {
    print('Animation completed: $item');
  },
  itemBuilder: (context, item, index) {
    return Text(item);
  },
)
```

## Best Practices Shown

1. **Container Sizing**: Proper height/width constraints for different directions
2. **Performance**: Using appropriate display and animation durations
3. **Accessibility**: Semantic widget structure and readable text
4. **Error Handling**: Graceful handling of empty lists and edge cases
5. **Memory Management**: Proper widget lifecycle management
6. **Responsive Design**: Adapting to different screen sizes

## Customization Examples

The app demonstrates various customization options:

- **Animation Curves**: `Curves.easeInOut`, `Curves.bounceOut`, `Curves.easeOutCubic`
- **Display Timing**: From 1 second to 5 seconds per item
- **Animation Speed**: From 300ms to 1200ms transitions
- **Visual Styling**: Colors, shadows, borders, gradients
- **Layout Integration**: Combining with other widgets like icons and buttons