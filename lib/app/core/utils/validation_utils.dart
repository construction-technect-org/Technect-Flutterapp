class ValidationUtils {
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

  // Business Contact Number Validation (same as mobile but with different message)
  static String? validateBusinessContactNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter business contact number";
    }
    if (value.trim().length != 10) {
      return "Contact number must be exactly 10 digits";
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return "Please enter a valid Indian mobile number (starting with 6, 7, 8, or 9)";
    }
    return null;
  }

  // Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter email address";
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }
    return null;
  }

  // Business Email Validation
  static String? validateBusinessEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter business email";
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }
    return null;
  }

  // Website URL Validation
  static String? validateWebsiteUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter website URL";
    }
    if (!RegExp(r'^https?:\/\/[^\s/$.?#].[^\s]*$').hasMatch(value.trim())) {
      return "Please enter a valid website URL (e.g., https://example.com)";
    }
    return null;
  }

  // GSTIN Number Validation
  static String? validateGSTINNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter GSTIN number";
    }
    if (value.trim().length != 15) {
      return "GSTIN number must be exactly 15 characters";
    }
    if (!RegExp(
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$',
    ).hasMatch(value.trim())) {
      return "Please enter a valid GSTIN number";
    }
    return null;
  }

  // Required Field Validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    return null;
  }

  // Name Validation (for business name, person name, etc.)
  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return "$fieldName can only contain letters and spaces";
    }
    return null;
  }

  // Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter password";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return "Password must contain at least one uppercase letter, one lowercase letter, and one number";
    }
    return null;
  }

  // Confirm Password Validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return "Please confirm password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  // PAN Number Validation
  static String? validatePANNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter PAN number";
    }
    if (value.trim().length != 10) {
      return "PAN number must be exactly 10 characters";
    }
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value.trim())) {
      return "Please enter a valid PAN number";
    }
    return null;
  }

  // Aadhaar Number Validation
  static String? validateAadhaarNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter Aadhaar number";
    }
    if (value.trim().length != 12) {
      return "Aadhaar number must be exactly 12 digits";
    }
    if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
      return "Please enter a valid Aadhaar number";
    }
    return null;
  }

  // Generic Length Validation
  static String? validateLength(
    String? value,
    int minLength,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (value.trim().length < minLength) {
      return "$fieldName must be at least $minLength characters";
    }
    if (value.trim().length > maxLength) {
      return "$fieldName must not exceed $maxLength characters";
    }
    return null;
  }

  // Generic Numeric Validation
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
      return "$fieldName must contain only numbers";
    }
    return null;
  }

  // Generic Decimal Validation
  static String? validateDecimal(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value.trim())) {
      return "$fieldName must be a valid number";
    }
    return null;
  }
}
