## 0.0.1 (Initial Release)

- Added the core functionality for scroll-based animations.
- Implemented scroll position detection and trigger mechanism.
- Supported basic animation types such as opacity, translation, and scaling.
- Included customizable animation parameters like duration, delay, and easing curves.
- Provided examples and documentation for getting started with Flutter animate on scroll.

## 0.0.2

- Migrated from using `MediaQueryData.fromWindow` to `MediaQueryData.fromView` for improved accuracy in obtaining the viewport size.
- Optimized the threshold calculation for triggering animations based on scroll position.

## 0.1.0

- Optimized scroll animation behaviour
- Added ZoomOut animation
- Added Text animation (typer effect with optional fade, wavy effect)

## 0.1.1

- Optimized scroll animation behaviour for custom animations

## 0.2.0

- Removed the need to attach global keys and scroll controllers.
- Introduced BaseAnimationConfig and BaseTextAnimationConfig.
- Fixed a bug (Looking up a deactivated widget's ancestor is unsafe).
- Updated the README to reflect the new changes.