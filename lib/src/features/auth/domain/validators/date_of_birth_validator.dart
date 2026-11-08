enum DateOfBirthError { incomplete, invalidDate, inFuture, tooYoung }

/// Domain rules reusable dob validation methods.
abstract final class DateOfBirthValidator {
  static const minimumAge = 13;
  static const earliestYear = 1900;

  static DateOfBirthError? validate({
    required int? year,
    required int? month,
    required int? day,
    required DateTime today,
  }) {
    if (year == null || month == null || day == null) {
      return DateOfBirthError.incomplete;
    }
    final date = toDate(year: year, month: month, day: day);
    if (date == null) return DateOfBirthError.invalidDate;

    final todayDate = DateTime(today.year, today.month, today.day);
    if (date.isAfter(todayDate)) return DateOfBirthError.inFuture;
    if (ageOn(todayDate, birthDate: date) < minimumAge) {
      return DateOfBirthError.tooYoung;
    }
    return null;
  }

  /// The date, or null when it doesn't exist on the calendar
  /// (DateTime silently rolls 31 April over to 1 May, so compare back).
  static DateTime? toDate({
    required int year,
    required int month,
    required int day,
  }) {
    if (year < earliestYear || month < 1 || month > 12 || day < 1) return null;
    final date = DateTime(year, month, day);
    final isRealDate =
        date.year == year && date.month == month && date.day == day;
    return isRealDate ? date : null;
  }

  /// Full years between [birthDate] and [today].
  static int ageOn(DateTime today, {required DateTime birthDate}) {
    final hadBirthdayThisYear =
        today.month > birthDate.month ||
        (today.month == birthDate.month && today.day >= birthDate.day);
    return today.year - birthDate.year - (hadBirthdayThisYear ? 0 : 1);
  }
}
