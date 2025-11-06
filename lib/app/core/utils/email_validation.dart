/// Comprehensive email validation class following RFC 5322 standards
/// This class provides robust email validation similar to Google's validation
class EmailValidation {
  // Comprehensive list of valid Top-Level Domains (TLDs)
  // Includes gTLDs, ccTLDs, and new gTLDs
  static const Set<String> _validTlds = {
    // Original gTLDs
    'com', 'org', 'net', 'edu', 'gov', 'mil', 'int', 'info', 'biz', 'name',
    'pro', 'museum', 'coop', 'aero', 'jobs', 'mobi', 'travel', 'tel', 'asia',
    'cat', 'xxx', 'post', 'geo',

    // New gTLDs (popular ones)
    // Note: 'io' and 'ai' are also valid ccTLDs, so they're included in the ccTLD section
    'app', 'dev', 'tech', 'cloud', 'online', 'site', 'website',
    'store', 'shop', 'blog', 'xyz', 'space', 'design', 'art', 'music', 'photo',
    'video', 'news', 'media', 'email', 'services', 'solutions', 'consulting',
    'company', 'network', 'systems', 'agency', 'marketing', 'business',
    'enterprises',
    'international',
    'global',
    'world',
    'group',
    'team',
    'social',
    'community', 'support', 'help', 'center', 'guide', 'wiki', 'today', 'live',
    'life', 'fun', 'games', 'win', 'bet', 'casino', 'poker', 'golf', 'tennis',
    'football', 'basketball', 'soccer', 'cricket', 'baseball', 'hockey',
    'fitness', 'health', 'medical', 'hospital', 'clinic', 'doctor', 'dentist',
    'law', 'legal', 'attorney', 'finance', 'bank', 'money', 'insurance',
    'investments',
    'trading',
    'cryptocurrency',
    'crypto',
    'blockchain',
    'bitcoin',
    'ethereum', 'nft', 'web3', 'metaverse', 'vr', 'data', 'analytics',
    // Note: 'ar' and 'ml' are valid ccTLDs (Argentina, Mali), included in ccTLD section
    'software', 'code', 'programming', 'developer', 'coding', 'engineer',
    'engineering', 'science', 'research', 'academy', 'education', 'school',
    'university',
    'college',
    'learn',
    'study',
    'courses',
    'training',
    'workshop',
    'seminar',
    'conference',
    'event',
    'meetup',
    'link',
    'web',
    'page',
    'landing',
    'home',
    'house',
    'realestate',
    'property',
    'estate',
    'build',
    'construction',
    'architect', 'architecture', 'interior', 'furniture', 'decor', 'garden',
    'landscaping', 'outdoor', 'nature', 'environment', 'green', 'eco',
    'sustainable', 'renewable', 'energy', 'solar', 'wind', 'hydro', 'electric',
    'car', 'auto', 'motor', 'vehicle', 'transport', 'trip', 'vacation',
    'holiday',
    'hotel',
    'booking',
    'reservation',
    'flight',
    'airline',
    'airport',
    'train', 'bus', 'taxi', 'ride', 'food', 'restaurant', 'cafe', 'bar', 'pub',
    'club', 'entertainment', 'party', 'celebration', 'festival', 'concert',
    'show', 'movie', 'film', 'cinema', 'theater', 'drama', 'comedy', 'action',
    'horror',
    'thriller',
    'romance',
    'sci-fi',
    'fantasy',
    'animation',
    'cartoon',
    'kids', 'family', 'children', 'baby', 'toddler', 'teen', 'youth', 'adult',
    'senior', 'elderly', 'retirement', 'pension',

    // Country Code TLDs (ccTLDs) - All country codes
    'ac', 'ad', 'ae', 'af', 'ag', 'ai', 'al', 'am', 'ao', 'aq', 'ar', 'as',
    'at', 'au', 'aw', 'ax', 'az', 'ba', 'bb', 'bd', 'be', 'bf', 'bg', 'bh',
    'bi', 'bj', 'bl', 'bm', 'bn', 'bo', 'bq', 'br', 'bs', 'bt', 'bv', 'bw',
    'by', 'bz', 'ca', 'cc', 'cd', 'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm',
    'cn', 'co', 'cr', 'cu', 'cv', 'cw', 'cx', 'cy', 'cz', 'de', 'dj', 'dk',
    'dm', 'do', 'dz', 'ec', 'ee', 'eg', 'eh', 'er', 'es', 'et', 'fi', 'fj',
    'fk', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge', 'gf', 'gg', 'gh', 'gi',
    'gl', 'gm', 'gn', 'gp', 'gq', 'gr', 'gs', 'gt', 'gu', 'gw', 'gy', 'hk',
    'hm', 'hn', 'hr', 'ht', 'hu', 'id', 'ie', 'il', 'im', 'in', 'io', 'iq',
    'ir', 'is', 'it', 'je', 'jm', 'jo', 'jp', 'ke', 'kg', 'kh', 'ki', 'km',
    'kn', 'kp', 'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 'li', 'lk', 'lr',
    'ls', 'lt', 'lu', 'lv', 'ly', 'ma', 'mc', 'md', 'me', 'mf', 'mg', 'mh',
    'mk', 'ml', 'mm', 'mn', 'mo', 'mp', 'mq', 'mr', 'ms', 'mt', 'mu', 'mv',
    'mw', 'mx', 'my', 'mz', 'na', 'nc', 'ne', 'nf', 'ng', 'ni', 'nl', 'no',
    'np', 'nr', 'nu', 'nz', 'om', 'pa', 'pe', 'pf', 'pg', 'ph', 'pk', 'pl',
    'pm', 'pn', 'pr', 'ps', 'pt', 'pw', 'py', 'qa', 're', 'ro', 'rs', 'ru',
    'rw', 'sa', 'sb', 'sc', 'sd', 'se', 'sg', 'sh', 'si', 'sj', 'sk', 'sl',
    'sm', 'sn', 'so', 'sr', 'ss', 'st', 'su', 'sv', 'sx', 'sy', 'sz', 'tc',
    'td', 'tf', 'tg', 'th', 'tj', 'tk', 'tl', 'tm', 'tn', 'to', 'tr', 'tt',
    'tv', 'tw', 'tz', 'ua', 'ug', 'uk', 'um', 'us', 'uy', 'uz', 'va', 'vc',
    've', 'vg', 'vi', 'vn', 'vu', 'wf', 'ws', 'ye', 'yt', 'za', 'zm', 'zw',
  };

  // Common two-part TLDs (e.g., co.uk, com.au)
  static const Set<String> _validTwoPartTlds = {
    'co.uk',
    'com.au',
    'co.in',
    'com.br',
    'co.za',
    'com.mx',
    'co.jp',
    'com.cn',
    'com.ar',
    'com.co',
    'com.pe',
    'com.ve',
    'com.ec',
    'com.uy',
    'com.py',
    'com.bo',
    'com.cr',
    'com.pa',
    'com.gt',
    'com.hn',
    'com.sv',
    'com.ni',
    'com.do',
    'com.cu',
    'com.jm',
    'com.tt',
    'com.bb',
    'com.gd',
    'com.lc',
    'com.vc',
    'com.ag',
    'com.bs',
    'com.bz',
    'com.sr',
    'com.gy',
    'com.fk',
    'co.nz',
    'co.id',
    'co.th',
    'co.my',
    'co.sg',
    'co.ph',
    'co.vn',
    'co.kr',
    'com.tw',
    'com.hk',
    'com.sg',
    'com.my',
    'com.th',
    'com.id',
    'com.ph',
    'com.vn',
    'com.kr',
    'net.au',
    'net.uk',
    'net.in',
    'org.uk',
    'org.au',
    'org.in',
    'edu.au',
    'edu.in',
    'gov.au',
    'gov.in',
    'gov.uk',
    'ac.uk',
    'ac.in',
    'ac.nz',
    'ac.za',
    'ac.jp',
    'ac.kr',
    'ac.cn',
    'ac.tw',
    'ac.hk',
    'sch.uk',
    'sch.in',
    'sch.au',
    'sch.nz',
    'sch.za',
    'sch.jp',
    'sch.kr',
  };

  /// Validates if a TLD is valid
  /// Returns true if TLD is valid, false otherwise
  /// Strict validation: only known TLDs are accepted
  static bool isValidTld(String? tld) {
    if (tld == null || tld.isEmpty) return false;

    final normalizedTld = tld.toLowerCase().trim();

    // Check single-part TLDs
    if (_validTlds.contains(normalizedTld)) {
      return true;
    }

    // Check two-part TLDs
    if (_validTwoPartTlds.contains(normalizedTld)) {
      return true;
    }

    // Strict validation: only known TLDs are accepted
    // This prevents fake/made-up TLDs like "hhfn", "xyz123", etc.
    return false;
  }

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

    // Check for invalid TLD typos first
    final invalidTlds = ['con', 'coom', 'coon', 'comn', 'c0m'];
    if (invalidTlds.contains(tld)) return false;

    // Validate TLD using comprehensive TLD list
    if (!isValidTld(tld)) {
      return false;
    }

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

    String tld;
    String? secondLevelDomain;
    String mainDomainName;

    // Check if it's a two-part TLD (e.g., co.uk, com.au)
    if (domainParts.length >= 3) {
      final lastTwoParts =
          '${domainParts[domainParts.length - 2]}.${domainParts.last}';
      if (_validTwoPartTlds.contains(lastTwoParts)) {
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

    // Validate TLD format - must be at least 2 characters
    if (tld.length < 2) {
      return "Please enter a valid email address with a valid domain";
    }

    // Use comprehensive TLD validation
    if (!isValidTld(tld)) {
      // Check for common typos first
      final invalidTlds = ['con', 'coom', 'coon', 'comn', 'c0m'];
      final singleTld = tld.contains('.') ? tld.split('.').last : tld;
      if (invalidTlds.contains(singleTld)) {
        return "Please enter a valid email address. The domain extension appears to be invalid or a typo";
      }
      return "Please enter a valid email address with a valid domain extension";
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
