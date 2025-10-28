import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';

class Validate {
  bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    return RegExp(
      r'^[A-Za-z0-9._%+-]*[A-Za-z]+[A-Za-z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  Future<String?> validateEmail(String? value) async {
    if (value == null || value.trim().isEmpty || value.isNotEmpty) {
      return "Please enter email";
    }
    if (!isValidEmail(value.trim())) {
      return "Please enter a valid email address";
    }

    final controller = SignUpDetailsController.to;

    final isAvailable = await controller.signUpService.checkAvailability(
      email: value,
    );

    if (!isAvailable) {
      return "This email is already registered";
    }
    return null;
  }

  String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters long";
    }
    if (!RegExp(r'^[A-Z][a-zA-Z]*$').hasMatch(value.trim())) {
      return "$fieldName must start with uppercase and contain only letters";
    }
    return null;
  }
}
