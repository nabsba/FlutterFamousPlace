import 'variables.dart';

int getIndexOfLanguage(String language) {
  return languages.indexOf(language);
}

Map<String, String> calculateAuthorizedLength({
  required String valueToTruncat,
  required String valueToNotTouch,
  required int authorizedLength,
}) {
  // Recursive helper function to truncate the valueToTruncat
  String truncateName(
      String valueToTruncat, String valueToNotTouch, int authorizedLength) {
    int totalNameLocation = valueToTruncat.length + valueToNotTouch.length;

    if (authorizedLength >= totalNameLocation) {
      return '${valueToTruncat.substring(0, valueToTruncat.length - 2)}..';
    }

    // Truncate the valueToTruncat and call recursively
    if (valueToTruncat.isNotEmpty) {
      return truncateName(
          valueToTruncat.substring(0, valueToTruncat.length - 1),
          valueToNotTouch,
          authorizedLength);
    }

    return ""; // If valueToTruncat is empty, return an empty string
  }

  // Calculate total length of valueToTruncat and valueToNotTouch
  int totalNameLocation = valueToTruncat.length + valueToNotTouch.length;
  if (authorizedLength >= totalNameLocation) {
    return {
      'valueToTruncat': valueToTruncat,
      'valueToNotTouch': valueToNotTouch
    };
  }

  // Truncate the valueToTruncat recursively
  valueToTruncat =
      truncateName(valueToTruncat, valueToNotTouch, authorizedLength);

  return {'valueToTruncat': valueToTruncat, 'valueToNotTouch': valueToNotTouch};
}
