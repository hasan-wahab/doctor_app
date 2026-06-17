import 'package:intl/intl.dart';

extension DateAndTime on DateTime {
  String get toReadDate => DateFormat('MM/dd/yyyy').format(this);
}

extension StringExtensions on String {
  // ─── Sentence Case ───
  String get toSentenceCase {
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }

  // ─── Title Case ───
  // "hello world" → "Hello World"
  String get toTitleCase {
    return split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}
