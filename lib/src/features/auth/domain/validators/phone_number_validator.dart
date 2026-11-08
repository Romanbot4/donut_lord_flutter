/// Domain rules reusable mmphone validation methods.
abstract final class PhoneNumberValidator {
  static const countryCode = '+95';

  static final _separators = RegExp(r'[\s-]');
  static final _localNumber = RegExp(r'^9\d{7,9}$');

  static String? normalize(String input) {
    var number = input.replaceAll(_separators, '');
    if (number.startsWith(countryCode)) {
      number = number.substring(countryCode.length);
    }
    if (number.startsWith('0')) number = number.substring(1);
    return _localNumber.hasMatch(number) ? '$countryCode$number' : null;
  }

  static bool isValid(String input) => normalize(input) != null;
}
