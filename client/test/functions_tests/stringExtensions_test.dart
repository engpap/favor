import 'package:flutter_test/flutter_test.dart';
import 'package:project/functions/stringExtensions.dart';

void main() {
  emailValidatorExtensionShouldWorkCorrectly();
}

void emailValidatorExtensionShouldWorkCorrectly() {
  group("emailValidatorExtension methods should work correctly", () {
    test('Email validation', () {
      expect('example@email.com'.isValidEmail(), true);
      expect('example@email.co.uk'.isValidEmail(), true);
      expect('example@email'.isValidEmail(), false);
      expect('example.email.com'.isValidEmail(), false);
      expect('example@.com'.isValidEmail(), false);
    });
  });
  test('Whitespace validation', () {
    expect(' '.isWhitespace(), true);
    expect('\t'.isWhitespace(), true);
    expect('\n'.isWhitespace(), true);
    expect('example'.isWhitespace(), false);
  });

  test('Double validation', () {
    expect('1.23'.isValidDouble(), true);
    expect('-1.23'.isValidDouble(), true);
    expect('1.23e10'.isValidDouble(), true);
    expect('example'.isValidDouble(), false);
  });

  test('Integer validation', () {
    expect('1'.isValidInt(), true);
    expect('-1'.isValidInt(), true);
    expect('7000000'.isValidInt(), true);
    expect('1.23'.isValidInt(), false);
    expect('example'.isValidInt(), false);
  });

  test('Password validation', () {
    expect('MyPassword123'.isValidPassword(), true);
    expect(''.isValidPassword(), false);
    expect(' '.isValidPassword(), false);
    expect('My123'.isValidPassword(), false);
    expect('mypassword'.isValidPassword(), false);
    expect('mypassword123'.isValidPassword(), false);
  });
}
