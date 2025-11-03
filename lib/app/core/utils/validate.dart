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

  /// Validates email domain to check for invalid or non-existent domains
  /// Returns error message if invalid, null if valid
  String? validateEmailDomain(String? email) {
    if (email == null || email.isEmpty) {
      return "Please enter a valid email address";
    }

    final value = email.trim().toLowerCase();

    // Extract domain part
    if (!value.contains('@')) {
      return "Please enter a valid email address";
    }

    final parts = value.split('@');
    if (parts.length != 2 || parts[1].isEmpty) {
      return "Please enter a valid email address";
    }

    final domain = parts[1];

    // Check for trailing dots or invalid characters in domain
    if (domain.endsWith('.') || domain.startsWith('.')) {
      return "Please enter a valid email address. Invalid domain format (trailing or leading dot)";
    }

    // Check for consecutive dots
    if (domain.contains('..')) {
      return "Please enter a valid email address with a valid domain";
    }

    // Extract domain parts
    final domainParts = domain.split('.');

    // Filter out empty parts (which could happen with trailing dots)
    domainParts.removeWhere((part) => part.isEmpty);

    if (domainParts.length < 2) {
      return "Please enter a valid email address with a valid domain";
    }

    // Common two-part TLDs (e.g., co.uk, com.au, co.in)
    final twoPartTlds = [
      'co.uk',
      'com.au',
      'co.in',
      'com.br',
      'co.za',
      'com.mx',
      'co.jp',
      'com.cn',
    ];

    String tld;
    String? secondLevelDomain;
    String mainDomainName;

    // Check if it's a two-part TLD
    if (domainParts.length >= 3) {
      final lastTwoParts =
          '${domainParts[domainParts.length - 2]}.${domainParts.last}';
      if (twoPartTlds.contains(lastTwoParts)) {
        tld = lastTwoParts;
        secondLevelDomain = domainParts[domainParts.length - 3];
        mainDomainName = domainParts.length >= 4
            ? domainParts[domainParts.length - 4]
            : domainParts[domainParts.length - 3];
      } else {
        tld = domainParts.last;
        secondLevelDomain = domainParts.length >= 2
            ? domainParts[domainParts.length - 2]
            : null;
        mainDomainName = secondLevelDomain ?? domainParts.first;
      }
    } else {
      tld = domainParts.last;
      mainDomainName = domainParts[domainParts.length - 2];
    }

    // Validate TLD format - must be at least 2 characters and only letters (or dot for two-part TLDs)
    if (tld.length < 2) {
      return "Please enter a valid email address with a valid domain";
    }

    // For two-part TLDs, validate both parts
    if (tld.contains('.')) {
      final tldParts = tld.split('.');
      for (final part in tldParts) {
        if (!RegExp(r'^[a-z]{2,63}$').hasMatch(part)) {
          return "Please enter a valid email address with a valid domain";
        }
      }
    } else {
      if (!RegExp(r'^[a-z]{2,63}$').hasMatch(tld)) {
        return "Please enter a valid email address with a valid domain";
      }
    }

    // List of known invalid TLD typos (commonly mistyped)
    final invalidTlds = [
      'con', // typo of .com
      'coom', // typo of .com
      'coon', // typo of .com
      'comn', // typo of .com
      'c0m', // typo of .com (zero instead of 'o')
    ];

    // Check for known invalid TLDs (typos) - only for single-part TLDs
    if (!tld.contains('.') && invalidTlds.contains(tld)) {
      return "Please enter a valid email address. The domain extension appears to be invalid or a typo";
    }

    // Common email providers
    final commonEmailProviders = [
      'gmail',
      'yahoo',
      'outlook',
      'hotmail',
      'icloud',
      'protonmail',
      'aol',
      'mail',
      'live',
      'msn',
    ];

    // Extract the actual provider name (handle subdomains like mail.gmail.com -> gmail)
    final providerName = secondLevelDomain ?? mainDomainName;

    // If it's a common email provider, validate the TLD
    if (commonEmailProviders.contains(providerName.toLowerCase())) {
      // Block obvious typos: .con (should be .com), .cm (should be .com)
      final singleTld = tld.contains('.') ? tld.split('.').last : tld;
      if (singleTld == 'con' || singleTld == 'cm') {
        return "Please enter a valid email address. The domain extension appears to be invalid (did you mean .com?)";
      }
      // For gmail specifically, .io is almost certainly a typo since Gmail uses .com
      if (providerName.toLowerCase() == 'gmail' && singleTld == 'io') {
        return "Please enter a valid email address. Gmail uses .com domain extension";
      }
      // For yahoo and outlook with .io or .cm, block as likely typos
      if ((providerName.toLowerCase() == 'yahoo' ||
              providerName.toLowerCase() == 'outlook') &&
          (singleTld == 'io' || singleTld == 'cm')) {
        return "Please enter a valid email address. The domain extension appears to be invalid (did you mean .com?)";
      }
    }

    // Additional validation: Validate each domain part
    // For two-part TLDs, we validate all parts except the last two
    // For single-part TLDs, we validate all parts except the last one
    final partsToValidate = tld.contains('.')
        ? domainParts.sublist(0, domainParts.length - 2)
        : domainParts.sublist(0, domainParts.length - 1);

    // Validate each domain part
    for (final part in partsToValidate) {
      if (part.isEmpty) {
        return "Please enter a valid email address with a valid domain";
      }
      // Validate domain name segments don't start or end with hyphen
      if (part.startsWith('-') || part.endsWith('-')) {
        return "Please enter a valid email address with a valid domain";
      }
      // Validate domain name segments contain only valid characters
      if (!RegExp(r'^[a-z0-9-]+$').hasMatch(part)) {
        return "Please enter a valid email address with a valid domain";
      }
    }

    return null; // Domain appears valid
  }

  Future<String?> validateEmail(String? email) async {
    final value = email?.trim() ?? "";

    // First check basic email format
    if (!isValidEmail(value)) {
      return "Please enter a valid email address";
    }

    // Then validate domain
    final domainError = validateEmailDomain(value);
    if (domainError != null) {
      return domainError;
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

  String? validateBusinessName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters long";
    }
    // Allow CamelCase segments separated by optional space/underscore, each segment starts uppercase and may contain letters or numbers (e.g., Studio52, Build4U, Tech2Win)
    if (!RegExp(
      r'^[A-Z][a-zA-Z0-9]*(?:[ _]?[A-Z][a-zA-Z0-9]*)*$',
    ).hasMatch(value.trim())) {
      return "$fieldName must have each word start uppercase and contain letters or numbers";
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
