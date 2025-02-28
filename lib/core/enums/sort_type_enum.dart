enum SortTypeEnum {
  asc,
  desc,
}

extension Value on SortTypeEnum {
  String get text {
    switch (this) {
      case SortTypeEnum.asc:
        return 'Ascending';
      case SortTypeEnum.desc:
        return 'Descending';
    }
  }
}
