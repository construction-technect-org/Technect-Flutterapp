import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';

class Validate {
  bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    if (email.length > 254) return false;
    final regex = RegExp(
      r"^(?!.*\.\.)[A-Za-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@[A-Za-z0-9-]+\.[A-Za-z]{2,63}$",
    );
    return regex.hasMatch(email);
  }

  Future<String?> validateEmail(String? email) async {
    final value = email?.trim() ?? "";
    if (!isValidEmail(value)) {
      return "Please enter a valid email address";
    }

    try {
      final isAvailable = await SignUpService().checkAvailability(email: value);
      if (!isAvailable) {
        return "This email is already registered";
      } else {
        return "";
      }
    } catch (e) {
      return "Error checking email availability";
    } finally {}
  }

  String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters long";
    }
    // Allow CamelCase and optional spaces/underscores between words; each segment must start with uppercase and contain only letters
    if (!RegExp(r'^[A-Z][a-z]*(?:[ _]?[A-Z][a-z]*)*$').hasMatch(value.trim())) {
      return "$fieldName must have each word start with uppercase and contain only letters";
    }
    return null;
  }

  Future<bool> validateGSTAvailability(String value) async {
    if (value.isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter GSTIN number");
      return false;
    } else if (value.length != 15) {
      SnackBars.errorSnackBar(content: "GSTIN must be exactly 15 characters");
      return false;
    } else if (!RegExp(
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$',
    ).hasMatch(value)) {
      SnackBars.errorSnackBar(content: "Invalid GSTIN format");
      return false;
    }
    final isAvailable = await SignUpService().checkAvailability(
      gstNumber: value,
    );
    if (isAvailable) {
      SnackBars.successSnackBar(content: "GSTIN verified successfully!");
      return true;
    } else {
      SnackBars.errorSnackBar(
        content: "User with this GST number already exists",
      );
      return false;
    }
  }

  // Indian Mobile Number Validation
  static String? validateIndianMobileNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter mobile number";
    }
    if (value.trim().length != 10) {
      return "Mobile number must be exactly 10 digits";
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return "Please enter a valid Indian mobile number (starting with 6, 7, 8, or 9)";
    }
    return null;
  }

  /// Validates mobile number format with strict rules
  /// Returns error message if invalid, null if valid
  /// Checks for:
  /// - Empty or null values (returns null, handled separately)
  /// - Length (must be 10 digits)
  /// - All identical digits (e.g., 1111111111, 2222222222)
  /// - All zeros after first digit (e.g., 6000000000, 7000000000)
  /// - Valid Indian mobile number format (starts with 6, 7, 8, or 9)
  static String? validateMobileNumber(String? mobileNumber) {
    if (mobileNumber == null || mobileNumber.trim().isEmpty) {
      return null; // Empty validation is handled separately
    }

    final digits = mobileNumber.trim();

    // Check length (should be 10 digits for Indian numbers)
    if (digits.length != 10) {
      return "Enter a valid mobile number.";
    }

    // Check if all digits are identical (e.g., 1111111111, 2222222222)
    if (digits.length > 1) {
      final firstDigit = digits[0];
      final allSame = digits.split('').every((digit) => digit == firstDigit);
      if (allSame) {
        return "Enter a valid mobile number.";
      }
    }

    // Check if all zeros after first digit (e.g., 6000000000, 7000000000)
    if (digits.length > 1) {
      final restDigits = digits.substring(1);
      if (restDigits == '0' * restDigits.length) {
        return "Enter a valid mobile number.";
      }
    }

    // Check if it's a valid Indian mobile number (starts with 6, 7, 8, or 9)
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(digits)) {
      return "Enter a valid mobile number.";
    }

    return null; // Valid
  }
}
