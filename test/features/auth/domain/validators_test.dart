import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

void main() {
  group('PhoneNumberValidator', () {
    test('normalizes a local number to +959 form', () {
      expect(PhoneNumberValidator.normalize('09254135592'), '+959254135592');
    });

    test('strips spaces, dashes and a leading 0', () {
      expect(PhoneNumberValidator.normalize('09 2541-35592'), '+959254135592');
    });

    test('accepts 9 followed by 7 to 9 digits', () {
      expect(PhoneNumberValidator.isValid('91234567'), isTrue);
      expect(PhoneNumberValidator.isValid('9123456789'), isTrue);
    });

    test(
      'rejects numbers that are too short, too long or not starting with 9',
      () {
        expect(PhoneNumberValidator.isValid('0925413'), isFalse);
        expect(PhoneNumberValidator.isValid('09254135592123'), isFalse);
        expect(PhoneNumberValidator.isValid('08254135592'), isFalse);
      },
    );
  });

  group('OtpValidator', () {
    test('accepts exactly six digits', () {
      expect(OtpValidator.isComplete('123456'), isTrue);
    });

    test('rejects short or non-numeric codes', () {
      expect(OtpValidator.isComplete('12345'), isFalse);
      expect(OtpValidator.isComplete('12345a'), isFalse);
    });
  });

  group('NameValidator', () {
    test('requires a first name', () {
      expect(
        NameValidator.validateFirstName('  '),
        NameValidationError.required,
      );
    });

    test('allows an empty last name', () {
      expect(NameValidator.validateLastName(''), isNull);
    });

    test('rejects digits', () {
      expect(
        NameValidator.validateFirstName('Ye Min 2'),
        NameValidationError.invalidCharacters,
      );
    });

    test('accepts Myanmar script', () {
      expect(NameValidator.validateFirstName('ရဲမင်း'), isNull);
    });

    test('rejects names longer than the maximum length', () {
      expect(
        NameValidator.validateFirstName('a' * (NameValidator.maxLength + 1)),
        NameValidationError.tooLong,
      );
    });
  });

  group('DateOfBirthValidator', () {
    final today = DateTime(2026, 11, 9);

    DateOfBirthError? validate(int? year, int? month, int? day) =>
        DateOfBirthValidator.validate(
          year: year,
          month: month,
          day: day,
          today: today,
        );

    test('is incomplete until day, month and year are all given', () {
      expect(validate(1990, 5, null), DateOfBirthError.incomplete);
    });

    test('rejects dates that do not exist', () {
      expect(validate(1990, 4, 31), DateOfBirthError.invalidDate);
      expect(validate(2001, 2, 29), DateOfBirthError.invalidDate);
    });

    test('accepts 29 February in a leap year', () {
      expect(validate(2000, 2, 29), isNull);
    });

    test('rejects a date in the future', () {
      expect(validate(2027, 1, 1), DateOfBirthError.inFuture);
    });

    test('rejects anyone younger than the minimum age', () {
      expect(validate(2013, 11, 10), DateOfBirthError.tooYoung);
    });

    test('accepts someone turning the minimum age today', () {
      expect(validate(2013, 11, 9), isNull);
    });
  });
}
