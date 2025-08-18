# Changelog

All notable changes to the AnimatedCycler package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2025-08-18

### Fixed
- Fixed `loop: false` parameter not working properly - the widget now correctly stops at the last item when loop is disabled
- Fixed autoPlay to stop automatically when reaching the last item with `loop: false`
- Added proper boundary checks for next/previous item navigation
- Added animation completion callbacks to all navigation methods (nextItem, previousItem, goToIndex)

### Improved
- Enhanced code quality by fixing all lint warnings
- Improved code formatting to meet Dart style guidelines (80-character line limit)
- Added comprehensive test coverage for loop functionality
- Added example demonstrating `loop: false` behavior

### Documentation
- Updated CHANGELOG.md with version history

## [1.0.2] - 2025-08-18

### Internal
- Version skipped due to publishing process

## [1.0.0] - 2025-08-03

### Added
- Initial release of AnimatedCycler package
- Support for both vertical and horizontal animation directions
- Generic type support for any data type
- Automatic cycling with customizable display and animation durations
- Manual control methods: `nextItem()`, `previousItem()`, `goToIndex()`
- Auto-play controls: `togglePlayPause()`, `pause()`, `resume()`
- Named constructors: `AnimatedCycler.vertical()` and `AnimatedCycler.horizontal()`
- Customizable animation curves (defaults to `Curves.easeInOut`)
- Item tap callbacks with `onItemTap` parameter
- Animation completion callbacks with `onAnimationComplete` parameter
- Loop control with `loop` parameter
- Performance optimizations for smooth animations
- Comprehensive documentation with API reference
- Example usage code for common scenarios

### Features
- **Bidirectional Animation**: Smooth transitions in both vertical and horizontal directions
- **Type Safety**: Full generic type support with Dart's type system
- **Flexible Sizing**: Configurable container size (height for vertical, width for horizontal)
- **Auto-play Control**: Start, stop, pause, and resume functionality
- **Manual Navigation**: Programmatic control over item selection
- **Custom Styling**: Complete control through custom `itemBuilder` function
- **Event Handling**: Tap detection and animation completion callbacks
- **Performance Optimized**: Efficient rendering with minimal rebuilds

### Technical Details
- Minimum Flutter SDK: `>=3.0.0`
- Minimum Dart SDK: `>=2.17.0`
- Zero external dependencies (Flutter framework only)
- Stateful widget with `TickerProviderStateMixin` for smooth animations
- Uses `AnimationController` and `Transform.translate` for optimal performance
- Automatic cleanup of timers and animation controllers

### Documentation
- Comprehensive README with usage examples
- Complete API documentation with dartdoc comments
- Example code for vertical and horizontal usage
- Testing guidelines and examples
- Contributing guidelines for developers

---

## Future Releases

### Planned Features for v1.1.0
- [ ] Pause on hover/interaction support
- [ ] Custom transition effects (fade, scale, slide variations)
- [ ] Accessibility improvements (screen reader support)
- [ ] Performance metrics and optimization tools
- [ ] More animation curve presets

### Planned Features for v1.2.0
- [ ] Multiple item display (show 2-3 items at once)
- [ ] Drag/swipe gestures for manual control
- [ ] Indicator dots/progress visualization
- [ ] Reverse direction option
- [ ] Custom timing per item support

### Planned Features for v2.0.0
- [ ] Breaking changes for improved API
- [ ] Advanced layout options (grid, staggered)
- [ ] Built-in common item templates
- [ ] Animation presets library
- [ ] Enhanced accessibility features

---

## Release Notes Format

Each release will include:
- **Added**: New features and capabilities
- **Changed**: Changes to existing functionality
- **Deprecated**: Features marked for removal in future versions
- **Removed**: Features removed in this version
- **Fixed**: Bug fixes and improvements
- **Security**: Security-related improvements

## Contributing

To contribute to this changelog:
1. Follow the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
2. Add entries under "Unreleased" section during development
3. Move entries to versioned section when releasing
4. Use semantic versioning for version numbers
5. Include migration notes for breaking changes