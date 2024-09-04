String? extractLastNumber(String input) {
  final regex = RegExp(r'([\u0660-\u0669]+)\s*$');
  final match = regex.firstMatch(input);
  return match?.group(1);
}