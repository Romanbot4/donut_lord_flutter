enum NameValidationError { required, tooLong, invalidCharacters }

/// Domain rules reusable user_name validation methods.
abstract final class NameValidator {
  static const maxLength = 50;

  /// Unicode letters, combining marks (Myanmar vowel signs, medials, virama
  /// and tone marks are category M), and spaces. Digits of any script fail.
  static final _allowedCharacters = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);

  static NameValidationError? validateFirstName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return NameValidationError.required;
    return _validateCharacters(name);
  }

  static NameValidationError? validateLastName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return null;
    return _validateCharacters(name);
  }

  /// Joins the trimmed parts into the single display name the API stores.
  static String fullName(String firstName, String lastName) {
    return [
      firstName.trim(),
      lastName.trim(),
    ].where((part) => part.isNotEmpty).join(' ');
  }

  static NameValidationError? _validateCharacters(String name) {
    if (name.runes.length > maxLength) return NameValidationError.tooLong;
    if (!_allowedCharacters.hasMatch(name)) {
      return NameValidationError.invalidCharacters;
    }
    return null;
  }
}
