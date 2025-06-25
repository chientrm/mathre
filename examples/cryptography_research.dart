import 'package:mathre/cryptography.dart';
import 'dart:math' as math;

void main() {
  print('🔐 Mathematical Cryptography Research with Dart\n');

  // Classical Ciphers
  print('=== Classical Cryptography ===');
  String message = 'HELLO CRYPTOGRAPHY WORLD';

  // Caesar Cipher
  print('Original: $message');
  String caesar = Cryptography.caesarCipher(message, 3);
  print('Caesar (+3): $caesar');
  String caesarDecrypt = Cryptography.caesarCipher(caesar, -3);
  print('Caesar (-3): $caesarDecrypt');

  // Vigenère Cipher
  String key = 'DART';
  String vigenere = Cryptography.vigenereCipher(message, key);
  print('Vigenère (key: $key): $vigenere');
  String vigenereDecrypt =
      Cryptography.vigenereCipher(vigenere, key, decrypt: true);
  print('Vigenère decrypt: $vigenereDecrypt');

  print('\n=== Frequency Analysis ===');
  String sampleText = '''
  The quick brown fox jumps over the lazy dog. This pangram contains every 
  letter of the alphabet at least once, making it useful for testing 
  cryptographic algorithms and frequency analysis techniques.
  ''';

  var frequencies = Cryptography.frequencyAnalysis(sampleText);
  print('Letter frequencies in sample text:');
  var sortedFreqs = frequencies.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  for (var entry in sortedFreqs.take(10)) {
    print('${entry.key}: ${(entry.value * 100).toStringAsFixed(2)}%');
  }

  double chiSquared = Cryptography.chiSquaredTest(sampleText);
  print('Chi-squared test result: ${chiSquared.toStringAsFixed(4)}');
  print('(Lower values indicate more English-like text)');

  print('\n=== RSA Cryptography ===');
  try {
    var keys = Cryptography.generateRSAKeys();
    print('RSA Keys Generated:');
    print(
        'Public Key (n, e): (${keys['publicKey']['n']}, ${keys['publicKey']['e']})');
    print(
        'Private Key (n, d): (${keys['privateKey']['n']}, ${keys['privateKey']['d']})');
    print('Prime factors: p=${keys['primes']['p']}, q=${keys['primes']['q']}');
    print('φ(n) = ${keys['phi']}');

    // Test RSA encryption/decryption with a small number
    int testMessage = 42;
    print('\nTesting RSA with message: $testMessage');

    var encrypted = Cryptography.rsaEncrypt(
        testMessage, keys['publicKey']['n'], keys['publicKey']['e']);
    print('Encrypted: $encrypted');

    var decrypted = Cryptography.rsaDecrypt(
        encrypted.toInt(), keys['privateKey']['n'], keys['privateKey']['d']);
    print('Decrypted: $decrypted');
    print('Success: ${decrypted.toInt() == testMessage}');
  } catch (e) {
    print('RSA demonstration failed: $e');
    print('(This is normal for educational implementation)');
  }

  print('\n=== Cryptanalysis Research ===');

  // Test different cipher strengths
  List<String> testTexts = [
    'HELLO WORLD', // Very short
    'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', // English pangram
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ', // Alphabet
    'AAAAAAAAAAAAAAAAAAAAAAAAAAA', // Repeated character
  ];

  for (String text in testTexts) {
    String encrypted = Cryptography.vigenereCipher(text, 'SECRET');
    double chi = Cryptography.chiSquaredTest(encrypted);
    print(
        'Text: "${text.substring(0, math.min(20, text.length))}"${text.length > 20 ? '...' : ''}');
    print('  Chi-squared after Vigenère: ${chi.toStringAsFixed(4)}');
  }

  print('\n🔬 Cryptography research complete!');
  print(
      'This demonstrates basic cryptographic concepts for educational purposes.');
}
