import '/core/localization/app_strings.dart';

enum LanguageEnum {
  en,
  ar,
}

extension LanguageExtension on LanguageEnum {
  String get value {
    switch (this) {
      case LanguageEnum.en:
        return AppStrings.english;
      case LanguageEnum.ar:
        return AppStrings.arabic;
      }
  }
}
