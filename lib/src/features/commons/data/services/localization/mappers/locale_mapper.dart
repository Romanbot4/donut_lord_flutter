import 'dart:ui';

abstract class LocaleMapper {
  static Locale? fromSystemLocaleString(String source) {
    final chunks = source.split('_');
    return Locale(chunks.first, chunks.length > 1 ? chunks.last : null);
  }
}
