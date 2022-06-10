class Validations {
  static String validateName(String value) {
    if (value.isEmpty) return 'Нэрээ оруулна уу';
    final RegExp nameExp = new RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value)) return 'Зөвхөн үсгээр бүтсэн нэр оруулна уу';
    return null;
  }

  static String validateEmail(String value, [bool isRequried = true]) {
    if (value.isEmpty && isRequried) return 'Имэйлээ оруулна уу';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) return 'Хүчингүй мэйл хаяг';
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty || value.length < 6) return 'Зөв нууц үг оруулна уу.';
    return null;
  }
}
