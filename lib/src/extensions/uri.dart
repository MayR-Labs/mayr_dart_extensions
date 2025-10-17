part of './../extensions.dart';

extension UriExtensions on Uri {
  /// Adds a query parameter to the URI.
  ///
  /// Example:
  /// ```dart
  /// final uri = Uri.parse('https://example.com');
  /// uri.addQueryParam('key', 'value'); // https://example.com?key=value
  /// ```
  Uri addQueryParam(String key, String value) {
    final params = Map<String, String>.from(queryParameters);
    params[key] = value;
    return replace(queryParameters: params);
  }

  /// Removes a query parameter from the URI.
  ///
  /// Example:
  /// ```dart
  /// final uri = Uri.parse('https://example.com?key=value');
  /// uri.removeQueryParam('key'); // https://example.com
  /// ```
  Uri removeQueryParam(String key) {
    final params = Map<String, String>.from(queryParameters);
    params.remove(key);
    return replace(queryParameters: params);
  }

  /// Checks if the URI has a specific query parameter.
  ///
  /// Example:
  /// ```dart
  /// final uri = Uri.parse('https://example.com?key=value');
  /// uri.hasQueryParam('key'); // true
  /// ```
  bool hasQueryParam(String key) => queryParameters.containsKey(key);

  /// Gets the value of a query parameter.
  ///
  /// Example:
  /// ```dart
  /// final uri = Uri.parse('https://example.com?key=value');
  /// uri.getQueryParam('key'); // 'value'
  /// ```
  String? getQueryParam(String key) => queryParameters[key];

  /// Replaces all query parameters with the given map.
  ///
  /// Example:
  /// ```dart
  /// final uri = Uri.parse('https://example.com?old=param');
  /// uri.replaceQueryParams({'new': 'param'}); // https://example.com?new=param
  /// ```
  Uri replaceQueryParams(Map<String, String> params) {
    return replace(queryParameters: params);
  }

  /// Checks if the URI uses a secure scheme (https).
  ///
  /// Example:
  /// ```dart
  /// Uri.parse('https://example.com').isSecure; // true
  /// Uri.parse('http://example.com').isSecure; // false
  /// ```
  bool get isSecure => scheme == 'https';

  /// Gets the domain without subdomain.
  ///
  /// Example:
  /// ```dart
  /// Uri.parse('https://api.example.com').domain; // 'example.com'
  /// Uri.parse('https://example.com').domain; // 'example.com'
  /// ```
  String get domain {
    final parts = host.split('.');
    if (parts.length >= 2) {
      return parts.skip(parts.length - 2).join('.');
    }
    return host;
  }

  /// Gets the subdomain if present.
  ///
  /// Example:
  /// ```dart
  /// Uri.parse('https://api.example.com').subdomain; // 'api'
  /// Uri.parse('https://example.com').subdomain; // ''
  /// ```
  String get subdomain {
    final parts = host.split('.');
    if (parts.length > 2) {
      return parts.take(parts.length - 2).join('.');
    }
    return '';
  }
}
