enum ScheduleDayEnum {
  sat,
  sun,
  mon,
  tue,
  wed,
  thu,
  fri,
}

extension ScheduleDayExtension on ScheduleDayEnum {
  int get dayIndex {
    switch (this) {
      case ScheduleDayEnum.sat:
        return 6;
      case ScheduleDayEnum.sun:
        return 7;
      case ScheduleDayEnum.mon:
        return 1;
      case ScheduleDayEnum.tue:
        return 2;
      case ScheduleDayEnum.wed:
        return 3;
      case ScheduleDayEnum.thu:
        return 4;
      case ScheduleDayEnum.fri:
        return 5;
    }
  }
}
