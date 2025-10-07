String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter a name";
  }
  final nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  if (!nameRegExp.hasMatch(value.trim())) {
    return "Name should only contain letters and spaces";
  }
  if (value.trim().length < 2) {
    return "Name should be at least 2 characters long";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter password";
  }
  final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[\W_])(?!.*\s).{8,}$');
  if (!passwordRegExp.hasMatch(value)) {
    return "Password must be at least 8 characters, contain uppercase, special char and no spaces";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter email";
  }
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegExp.hasMatch(value)) {
    return "Please enter valid email";
  }
  return null;
}

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
