String formatMoney(String number) {
  return number.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (Match match) => '${match.group(1)}.',
      );
}
