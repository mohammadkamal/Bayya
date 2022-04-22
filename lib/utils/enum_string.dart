class EnumString {
  static String convertToString(dynamic enumItem) {
    String temp = enumItem.toString();
    var list = temp.split('.');
    return list.last;
  }

  static dynamic convertFromString(List enumValues, String item) {
    var returnValue;
    for (var value in enumValues) {
      if (item == convertToString(value)) {
        returnValue = value;
        break;
      }
    }

    if (returnValue != null) {
      return returnValue;
    } else {
      throw Exception('Invalid enum value');
    }
  }
}
