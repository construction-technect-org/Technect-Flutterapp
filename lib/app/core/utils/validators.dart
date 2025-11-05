String? validateConfirmPassword(String? value, String? originalPassword) {
  if (value == null || value.isEmpty) {
    return "Please confirm password";
  }
  if (value != originalPassword) {
    return "Confirm password does not match";
  }
  return null;
}

String? validateFields(String? value, String? name) {
  if (value == null || value.isEmpty) {
    return "Please enter $name";
  }
  final nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  if (!nameRegExp.hasMatch(value.trim())) {
    return "$name should only contain letters.";
  }

  return null;
}

String? validatePinCode(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter pin code";
  }

  final pinCodeRegExp = RegExp(r'^[1-9][0-9]{2}\s?[0-9]{3}$');

  if (!pinCodeRegExp.hasMatch(value.trim())) {
    return "Enter valid 6-digit pin code";
  }
  return null;
}
