String celciusToFahr(dynamic text) {
  return ((text == null)
          ? (text.toString())
          : (double.parse(text.toString()) * (9 / 5) + 32).round().toString()) +
      '°F';
}

double celciusToFahrInt(dynamic text) {
  return ((text == null) ? 0.0 : double.parse(text.toString()) * (9 / 5) + 32);
}
