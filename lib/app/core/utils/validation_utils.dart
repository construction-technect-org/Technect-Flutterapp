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

  // Website URL Validation
  static String? validateWebsiteUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter website URL";
    }
    // if (!RegExp(r'^https?:\/\/[^\s/$.?#].[^\s]*$').hasMatch(value.trim())) {}
    final input = value.trim();

    // Browsers accept URLs with or without scheme; assume https if missing
    // final normalized = input.contains('://') ? input : 'https://$input';
    final normalized = input;

    Uri? uri;
    try {
      uri = Uri.tryParse(normalized);
    } catch (_) {}

    if (uri == null) {
      return "Please enter a valid website URL (e.g., https://example.com)";
    }

    // Must be http or https
    if (!(uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
      return "URL must start with http:// or https://";
    }

    // Must have an authority (host[, port]) and no spaces
    if (!uri.hasAuthority || uri.host.isEmpty || input.contains(' ')) {
      return "Please enter a valid website URL (e.g., https://example.com)";
    }

    // Validate host: domain, IPv4, or localhost
    final host = uri.host;
    final isValidHost =
        _isValidDomain(host) || _isValidIPv4(host) || host == 'localhost';
    if (!isValidHost) {
      return "Please enter a valid website URL (e.g., https://example.com)";
    }

    // Optional: validate port range if present
    if (uri.hasPort && (uri.port < 1 || uri.port > 65535)) {
      return "Please enter a valid website URL (invalid port)";
    }

    return null;
  }

  // Domain validation: labels 1-63, alnum with hyphens inside, no leading/trailing hyphen
  static bool _isValidDomain(String host) {
    if (host.endsWith('.')) return false; // trailing dot not allowed in forms
    final parts = host.split('.');
    if (parts.length < 2) return false; // need TLD or localhost

    final labelRegex = RegExp(
      r'^[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$',
    );
    for (final label in parts) {
      if (label.isEmpty) {
        return false;
      }
      // allow punycode labels too (xn--)
      if (!(labelRegex.hasMatch(label) || label.startsWith('xn--'))) {
        return false;
      }
    }
    // TLD should be alpha (or punycode) and >= 2 chars when not punycode
    final tld = parts.last;
    if (tld.startsWith('xn--')) return true;
    if (!RegExp(r'^[A-Za-z]{2,63}$').hasMatch(tld)) return false;
    return true;
  }

  static bool _isValidIPv4(String host) {
    final ipv4 = RegExp(
      r'^(?:25[0-5]|2[0-4]\d|1?\d?\d)(?:\.(?:25[0-5]|2[0-4]\d|1?\d?\d)){3}$',
    );
    return ipv4.hasMatch(host);
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
