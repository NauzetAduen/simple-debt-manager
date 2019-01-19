class Validator {
  static String validateString(String value) =>
      value.isEmpty ? "This field can not be empty" : null;
  static String validateQuantity(String value) {
    if (value.isEmpty) return "Add a quantity";
    if (double.parse(value) <= 0.0) return "Invalid quantity";
    return null;
  }
}
