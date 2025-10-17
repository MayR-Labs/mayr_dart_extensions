import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('UriExtensions', () {
    test('addQueryParam adds a parameter', () {
      final uri = Uri.parse('https://example.com');
      final updated = uri.addQueryParam('key', 'value');

      expect(updated.toString(), 'https://example.com?key=value');
    });

    test('removeQueryParam removes a parameter', () {
      final uri = Uri.parse('https://example.com?key=value&other=data');
      final updated = uri.removeQueryParam('key');

      expect(updated.toString(), 'https://example.com?other=data');
    });

    test('hasQueryParam checks for parameter existence', () {
      final uri = Uri.parse('https://example.com?key=value');

      expect(uri.hasQueryParam('key'), true);
      expect(uri.hasQueryParam('missing'), false);
    });

    test('getQueryParam retrieves parameter value', () {
      final uri = Uri.parse('https://example.com?key=value');

      expect(uri.getQueryParam('key'), 'value');
      expect(uri.getQueryParam('missing'), null);
    });

    test('replaceQueryParams replaces all parameters', () {
      final uri = Uri.parse('https://example.com?old=param');
      final updated = uri.replaceQueryParams({
        'new': 'param',
        'another': 'one',
      });

      expect(updated.hasQueryParam('old'), false);
      expect(updated.hasQueryParam('new'), true);
      expect(updated.hasQueryParam('another'), true);
    });

    test('isSecure checks for https', () {
      expect(Uri.parse('https://example.com').isSecure, true);
      expect(Uri.parse('http://example.com').isSecure, false);
    });

    test('domain extracts domain without subdomain', () {
      expect(Uri.parse('https://api.example.com').domain, 'example.com');
      expect(Uri.parse('https://www.example.com').domain, 'example.com');
      expect(Uri.parse('https://example.com').domain, 'example.com');
    });

    test('subdomain extracts subdomain', () {
      expect(Uri.parse('https://api.example.com').subdomain, 'api');
      expect(Uri.parse('https://www.api.example.com').subdomain, 'www.api');
      expect(Uri.parse('https://example.com').subdomain, '');
    });
  });
}
