# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/animated_cycler_test.dart
```

### Code Analysis
```bash
# Run static analysis
dart analyze

# Fix formatting issues
dart format .
```

### Example App
```bash
# Run the example app
cd example
flutter run
```

### Publishing Preparation
```bash
# Dry run to check if package is ready for publishing
flutter pub publish --dry-run

# Check package score
dart pub global activate pana
pana .
```

## High-Level Architecture

AnimatedCycler is a Flutter widget package that provides smooth, automatic cycling through a list of items with bidirectional animation support.

### Core Components

1. **AnimatedCycler Widget** (`lib/src/animated_cycler.dart`): The main stateful widget that handles:
   - Animation lifecycle management using `AnimationController`
   - Timer-based auto-play functionality
   - Manual control methods (next, previous, goToIndex)
   - Bidirectional animation support (vertical/horizontal)
   - Generic type support for flexibility

2. **AnimatedCyclerState**: Manages the widget's state and provides:
   - Animation control and timing
   - Item transition logic
   - Public methods for manual control
   - Play/pause functionality

### Key Design Patterns

- **Generic Type System**: The widget uses `AnimatedCycler<T>` to work with any data type
- **Builder Pattern**: Uses `itemBuilder` function to allow custom rendering of each item
- **Named Constructors**: Provides `.vertical()` and `.horizontal()` constructors for common use cases
- **GlobalKey Access**: Enables manual control through state access via GlobalKey

### Animation Architecture

The animation system uses a stack-based approach:
- Current item slides out in the animation direction
- Next item slides in from the opposite direction
- Uses `Transform.translate` with calculated offsets based on animation progress
- Supports customizable curves and durations

### Testing Strategy

The test suite (`test/animated_cycler_test.dart`) covers:
- Widget initialization and display
- Manual control methods
- Edge cases (empty lists, single items, invalid indices)
- Event callbacks (tap, animation complete)
- Size constraints and directional behavior
- Play/pause functionality
