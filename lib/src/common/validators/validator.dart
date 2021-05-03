typedef ValidationRule = String? Function(dynamic value);
typedef ValidationUnless = bool Function(dynamic value);

/// The generic validator class that can be used for various validation purposes
///
/// Subclass it accordingly to build your own kind of validation(s).
/// Refer to either [ValidatorNumber] or [ValidatorString] for more details.
///
/// The common use case is for [TextFormField] where you can add any of the validators in [TextFormField.validator] e.g.
/// ```dart
/// TextFormField(
///  decoration: InputDecoration(labelText: 'Test Less Than 5 and Positive'),
///  keyboardType: TextInputType.number,
///  validator: (v) => ValidatorNumber(v).lt(5).positive().build(),
/// );
/// ```
class Validator {
  dynamic value;

  List<ValidationRule> _rules = [];
  List<ValidationUnless> _checkers = [];

  Validator(this.value);

  Validator optional() {
    unless((v) {
      if (v == null) return true;

      return v.toString().isEmpty;
    });
    return this;
  }

  Validator unless(ValidationUnless checker) {
    _checkers.add(checker);
    return this;
  }

  Validator validate(ValidationRule rule) {
    _rules.add(rule);
    return this;
  }

  String? build() {
    // if any of the unless rules dont proceed to checking the rules below
    if (!_checkUnless(value)) return null;

    for (ValidationRule r in _rules) {
      String? err = r(value);
      if (err != null) return err;
    }

    return null;
  }

  bool _checkUnless(dynamic v) {
    for (ValidationUnless c in _checkers) {
      if (c(v)) return false;
    }

    return true;
  }
}
