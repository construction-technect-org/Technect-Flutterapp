/// Comprehensive email validation class following RFC 5322 standards
/// This class provides robust email validation similar to Google's validation
class EmailValidation {
  /// Comprehensive email validation following RFC 5322 standards
  /// Returns true if email is valid, false otherwise
  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;

    final trimmed = email.trim();

    // Check total length (RFC 5322 limit: 254 characters)
    if (trimmed.length > 254) return false;

    // Must contain exactly one @ symbol
    final atCount = '@'.allMatches(trimmed).length;
    if (atCount != 1) return false;

    final parts = trimmed.split('@');
    if (parts.length != 2) return false;

    final localPart = parts[0];
    final domain = parts[1];

    // Local part validation (before @)
    if (localPart.isEmpty || localPart.length > 64) return false;

    // Local part cannot start or end with dot
    if (localPart.startsWith('.') || localPart.endsWith('.')) return false;

    // Local part cannot have consecutive dots
    if (localPart.contains('..')) return false;

    // Local part cannot have spaces (unless quoted, but we'll keep it simple)
    if (localPart.contains(' ')) return false;

    // Validate local part characters (RFC 5322 allowed characters)
    // Allow: A-Z, a-z, 0-9, and special: !#$%&'*+/=?^_`{|}~-.
    // Check if it's a quoted string (starts and ends with quotes)
    if (localPart.startsWith('"') &&
        localPart.endsWith('"') &&
        localPart.length > 2) {
      // Quoted strings are valid per RFC 5322
      final quotedContent = localPart.substring(1, localPart.length - 1);
      // Allow most characters in quoted strings (simplified)
      if (quotedContent.isEmpty) {
        return false;
      }
    } else {
      // Regular unquoted local part - validate character by character
      // RFC 5322 allowed characters: A-Z, a-z, 0-9, !#$%&'*+/=?^_`{|}~-.
      for (int i = 0; i < localPart.length; i++) {
        final char = localPart[i];
        final code = char.codeUnitAt(0);
        // Check if character is alphanumeric
        final isAlphanumeric =
            (code >= 48 && code <= 57) || // 0-9
            (code >= 65 && code <= 90) || // A-Z
            (code >= 97 && code <= 122); // a-z
        // Check if character is allowed special character
        final isSpecial =
            char == '!' ||
            char == '#' ||
            char == '\$' ||
            char == '%' ||
            char == '&' ||
            char == "'" ||
            char == '*' ||
            char == '+' ||
            char == '/' ||
            char == '=' ||
            char == '?' ||
            char == '^' ||
            char == '_' ||
            char == '`' ||
            char == '{' ||
            char == '|' ||
            char == '}' ||
            char == '~' ||
            char == '-' ||
            char == '.';
        if (!isAlphanumeric && !isSpecial) {
          return false;
        }
      }
    }

    // Domain validation (after @)
    if (domain.isEmpty) return false;

    // Domain cannot start or end with dot or hyphen
    if (domain.startsWith('.') ||
        domain.endsWith('.') ||
        domain.startsWith('-') ||
        domain.endsWith('-')) {
      return false;
    }

    // Domain cannot have consecutive dots
    if (domain.contains('..')) return false;

    // Domain cannot have spaces
    if (domain.contains(' ')) return false;

    // Domain cannot have underscores (except in some special cases, but we'll disallow)
    if (domain.contains('_')) return false;

    // Split domain into parts
    final domainParts = domain.split('.');
    if (domainParts.length < 2) return false;

    // Validate each domain part
    for (final part in domainParts) {
      if (part.isEmpty) return false;

      // Each part cannot exceed 63 characters
      if (part.length > 63) return false;

      // Each part cannot start or end with hyphen
      if (part.startsWith('-') || part.endsWith('-')) return false;

      // Each part can only contain letters, numbers, and hyphens
      if (!RegExp(r'^[a-z0-9-]+$', caseSensitive: false).hasMatch(part)) {
        return false;
      }
    }

    // TLD (last domain part) validation
    final tld = domainParts.last.toLowerCase();

    // TLD must be at least 2 characters
    if (tld.length < 2) return false;

    // TLD cannot exceed 63 characters
    if (tld.length > 63) return false;

    // TLD should only contain letters (some TLDs have numbers, but we'll be strict)
    if (!RegExp(r'^[a-z]{2,63}$').hasMatch(tld)) {
      // Allow numeric TLDs for edge cases like .123 or .123domain
      if (!RegExp(r'^[a-z0-9]{2,63}$').hasMatch(tld)) {
        return false;
      }
    }

    // Check for invalid TLD typos
    final invalidTlds = ['con', 'coom', 'coon', 'comn', 'c0m'];
    if (invalidTlds.contains(tld)) return false;

    // Additional validation: Check for common email provider typos
    final domainLower = domain.toLowerCase();
    if (domainLower.contains('gmail') && (tld == 'io' || tld == 'cm')) {
      return false;
    }
    if ((domainLower.contains('yahoo') || domainLower.contains('outlook')) &&
        (tld == 'io' || tld == 'cm' || tld == 'con')) {
      return false;
    }

    return true;
  }

  /// Non-future email validation for TextField validators
  /// Returns error message if invalid, null if valid
  /// Does NOT check email availability (no API call)
  static String? validateEmailFormat(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "Please enter email address";
    }

    final trimmed = email.trim();

    // Check total length
    if (trimmed.length > 254) {
      return "Email address is too long (maximum 254 characters)";
    }

    // Basic format check
    if (!isValidEmail(trimmed)) {
      // Provide more specific error messages
      if (!trimmed.contains('@')) {
        return "Email address must contain @ symbol";
      }

      final parts = trimmed.split('@');
      if (parts.length != 2) {
        return "Email address must contain exactly one @ symbol";
      }

      final localPart = parts[0];
      final domain = parts[1];

      if (localPart.isEmpty) {
        return "Email address must have a local part (before @)";
      }

      if (domain.isEmpty) {
        return "Email address must have a domain (after @)";
      }

      if (localPart.length > 64) {
        return "Local part (before @) is too long (maximum 64 characters)";
      }

      if (localPart.startsWith('.') || localPart.endsWith('.')) {
        return "Local part cannot start or end with a dot";
      }

      if (localPart.contains('..')) {
        return "Local part cannot contain consecutive dots";
      }

      if (localPart.contains(' ')) {
        return "Local part cannot contain spaces";
      }

      if (domain.startsWith('.') ||
          domain.endsWith('.') ||
          domain.startsWith('-') ||
          domain.endsWith('-')) {
        return "Domain cannot start or end with dot or hyphen";
      }

      if (domain.contains('..')) {
        return "Domain cannot contain consecutive dots";
      }

      if (domain.contains(' ')) {
        return "Domain cannot contain spaces";
      }

      if (domain.contains('_')) {
        return "Domain cannot contain underscores";
      }

      final domainParts = domain.split('.');
      if (domainParts.length < 2) {
        return "Domain must include a top-level domain (e.g., .com, .org)";
      }

      final tld = domainParts.last.toLowerCase();
      if (tld.length < 2) {
        return "Top-level domain must be at least 2 characters";
      }

      if (tld.length > 63) {
        return "Top-level domain is too long (maximum 63 characters)";
      }

      return "Please enter a valid email address";
    }

    // Additional domain validation
    final domainError = validateEmailDomain(trimmed);
    if (domainError != null) {
      return domainError;
    }

    return null; // Valid email
  }

  /// Non-future email validation for TextField validators (alias for validateEmailFormat)
  /// Returns error message if invalid, null if valid
  /// Does NOT check email availability (no API call)
  static String? validateEmail(String? email) {
    return validateEmailFormat(email);
  }

  /// Legacy method - kept for backward compatibility
  /// Use validateEmail() instead
  @Deprecated('Use validateEmail() instead')
  static String? validateMail(String? mail) {
    return validateEmail(mail);
  }

  /// Validates email domain to check for invalid or non-existent domains
  /// Returns error message if invalid, null if valid
  static String? validateEmailDomain(String? email) {
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
}
