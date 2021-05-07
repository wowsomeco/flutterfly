# flutterfly

A collection of common widgets, validators, extensions, utilities, as well as some other stuffs that are currently non-existent in Flutter.

## Getting Started

- Add [flutterfly](https://pub.dev/packages/flutterfly) to your flutter package's pubspec.yaml file :

  ```yaml
  dependencies:
    flutterfly: ^<latest_version>
  ```

## Main Considerations

- Only includes the stuffs that don't exist yet, yet essentially important and is broadly re-used across our projects, hence we expect this library to be `open for extension, but closed for modification`
- Brutally **tested**

## Contents

- **Views**

  - Widget Components
    - URL Image with loading progress
    - Timeline

- **Common**

  - Extensions
    - String Extensions
      - Capitalize
      - ToDateTime
      - Digit Only
      - etc.
    - Num Extensions
      - isBetween(min, max)
    - Map Extensions
    - DateTime Extensions
      - Calculate Age
  - Validators
    - String Validator
      - Required
      - Min Length
      - Special Characters
      - Email
      - Valid Date
      - Allow Digits Only
      - Disallow any digits
      - No white space
      - Contains
      - etc.
    - Num Validator
      - Required
      - Positive
      - Greater Than
      - Less Than
      - Between
      - etc.
  - Utils
    - Connection Utils
      - Check Internet Connection

## Documentation

Coming Soon.

Pull requests are welcome :)

## License

**MIT**
