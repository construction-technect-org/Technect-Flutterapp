import 'package:construction_technect/app/core/utils/email_validation.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';

/// Main validation utility class
/// Provides validation methods for various input types including email, mobile, name, etc.
class Validate {
  // ==================== Email Validation ====================

  /// Non-future email validation for TextField validators
  /// Returns error message if invalid, null if valid
  /// Does NOT check email availability (no API call)
  static String? validateEmail(String? email) {
    return EmailValidation.validateEmail(email);
  }

  /// Future email validation for button actions
  /// Includes format validation AND availability check (API call)
  /// Returns error message if invalid, empty string if valid and available
  /// Only checks availability if format validation passes
  static Future<String?> validateEmailAsync(String? email) async {
    // First validate email format using the non-future method
    final formatError = validateEmail(email);
    if (formatError != null) {
      // Return null to indicate format error (don't show API error if format is invalid)
      // The format error will be shown by the validator
      return null; // Format error is handled by validator, don't show API error
    }

    // Only check email availability via API if format is valid
    try {
      final isAvailable = await SignUpService().checkAvailability(email: email);
      // If isAvailable is false, the email is already registered
      if (isAvailable == false) {
        return "This email is already registered";
      }
      // If isAvailable is true, the email is available
      if (isAvailable == true) {
        return ""; // Empty string means valid and available
      }
      // If isAvailable is null or unexpected, treat as error for safety
      return "Error checking email availability. Please try again.";
    } catch (e) {
      // Log the error for debugging
      if (kDebugMode) {
        print("Email availability check error: $e");
      }
      return "Error checking email availability. Please try again.";
    }
  }

  // ==================== Name Validation ====================

  /// Validates name format
  /// Allows CamelCase and optional spaces/underscores between words
  /// Each segment must start with uppercase and contain only letters
  static String? validateName(String? value, {String fieldName = "Name"}) {
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

  /// Validates business name format
  /// Allows words starting uppercase or common lowercase connectors (of, and, the, ...)
  /// Words may include letters, numbers, and &, -, . between alphanumerics
  /// Optional trailing hyphen allowed
  static String? validateBusinessName(
    String? value, {
    String fieldName = "Name",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters long";
    }
    // Allow words starting uppercase or common lowercase connectors (of, and, the, ...);
    // words may include letters, numbers, and &, -, . between alphanumerics; optional trailing hyphen allowed.
    // Examples accepted: "H&M Constructions", "Pro-Tech Builders", "A&B Traders", "Tech2Win", "Studio52",
    // "The International Association of Engineers and Technologists Research and Development Solutions Private Limited-".
    final pattern = RegExp(
      '^(?:'
      r'(?:[A-Z][a-zA-Z0-9]*(?:[&.\-][A-Za-z0-9]+)*)'
      '|(?:of|and|the|for|in|on|at|by|with|to|from)'
      ')'
      '(?:[ _]'
      r'(?:[A-Z][a-zA-Z0-9]*(?:[&.\-][A-Za-z0-9]+)*|(?:of|and|the|for|in|on|at|by|with|to|from))'
      r')*-?$',
    );
    if (!pattern.hasMatch(value.trim())) {
      return "Enter a valid $fieldName (letters/numbers/space/&/.-, common lowercase connectors allowed, optional trailing -)";
    }
    return null;
  }

  // ==================== Mobile Number Validation ====================

  /// Validates Indian mobile number format
  /// Must be exactly 10 digits starting with 6, 7, 8, or 9
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

  static String? validateMobileNumber(
    String? mobileNumber, {
    bool isOptional = false,
  }) {
    // Handle null or empty values
    if (mobileNumber == null || mobileNumber.trim().isEmpty) {
      if (isOptional) {
        return null;
      } else {
        return "Please enter mobile number";
      }
    }

    final digits = mobileNumber.trim();

    // Check length (should be 10 digits for Indian numbers)
    if (digits.length < 10) {
      return "Please enter 10 digits.";
    }

    if (digits.length > 10) {
      return "Mobile number must be exactly 10 digits";
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(digits)) {
      return "Please enter a valid mobile number.";
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

  /// Future mobile number validation for button actions
  /// Includes format validation AND availability check (API call)
  /// Returns error message if invalid, empty string if valid and available
  /// Only checks availability if format validation passes
  ///
  /// [mobileNumber] - The mobile number to validate
  /// [countryCode] - The country code (e.g., "+91")
  static Future<String?> validateMobileNumberAsync(
    String? mobileNumber, {
    String? countryCode,
  }) async {
    // First validate mobile number format using the non-future method
    final formatError = validateMobileNumber(mobileNumber);
    if (formatError != null) {
      return formatError; // Return format error immediately
    }

    // Only check availability if format is valid
    try {
      final isAvailable = await SignUpService().checkAvailability(
        mobileNumber: mobileNumber?.trim(),
        countryCode: countryCode,
      );
      if (!isAvailable) {
        return "This mobile number is already registered";
      } else {
        return ""; // Empty string means valid and available
      }
    } catch (e) {
      return "Error checking mobile number availability";
    }
  }

  // ==================== GST Validation ====================

  /// Validates GSTIN number format and availability
  static Future<bool> validateGSTAvailability(String value) async {
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
        content: "User with this GSTIN number already exists",
      );
      return false;
    }
  }
}
