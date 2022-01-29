abstract class Valid {
  static bool email(String email) {
    bool valid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return valid;
  }

  static bool password(String pass) {
    bool valid = pass.length >= 6;
    return valid;
  }

  static bool isRequired(String? val) {
    return val != null && val.isEmpty;
  }
}
