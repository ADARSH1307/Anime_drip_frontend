class MobileVerify{
  static bool validateMobile(String value) {
  String pattern = r'^(?:\+[0-9]{2})? ?[0-9]{10}$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    return true;
  } else if (!regExp.hasMatch(value)) {
    return true;
  }
  return false;
}
}