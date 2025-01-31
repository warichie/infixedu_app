class ValueChecker {
  static String checkString(dynamic value, {String defaultValue = ''}) {
    if (value == null) {
      return defaultValue;
    } else if (value is int || value is double) {
      return value.toString();
    } else if (value is String) {
      return value;
    } else {
      throw Exception('Unexpected type for value');
    }
  }

  static int? checkInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) {
      return null;
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value);
    } else {
      throw Exception('Unexpected type for value');
    }
  }

  static double checkDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) {
      return defaultValue;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    } else {
      throw Exception('Unexpected type for value');
    }
  }
}
