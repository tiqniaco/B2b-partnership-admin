
int getYear(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return date.year;
}
