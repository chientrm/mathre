/// Mathematical Cryptography Functions
///
/// This module provides cryptographic functions useful for research
/// and educational purposes in mathematical cryptography.

import 'dart:math' as math;
import 'number_theory.dart';

class Cryptography {
  /// Generate a random prime number within a range
  static int generateRandomPrime(int min, int max) {
    final random = math.Random();
    for (int attempt = 0; attempt < 1000; attempt++) {
      int candidate = min + random.nextInt(max - min);
      if (candidate % 2 == 0) candidate++;
      if (_isPrime(candidate)) {
        return candidate;
      }
    }
    throw Exception('Failed to generate prime in range');
  }

  /// Simple primality test
  static bool _isPrime(int n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }

  /// RSA Key Generation (simplified for research)
  static Map<String, dynamic> generateRSAKeys({int keySize = 512}) {
    // Generate two random primes
    int p = generateRandomPrime(100, 1000);
    int q = generateRandomPrime(100, 1000);

    // Ensure p != q
    while (p == q) {
      q = generateRandomPrime(100, 1000);
    }

    int n = p * q;
    int phi = (p - 1) * (q - 1);

    // Common public exponent
    int e = 65537;

    // Calculate private exponent
    int? dTemp = NumberTheory.modularInverse(e, phi);
    if (dTemp == null) {
      throw Exception('Failed to calculate private key');
    }
    int d = dTemp;

    return {
      'publicKey': {'n': n, 'e': e},
      'privateKey': {'n': n, 'd': d},
      'primes': {'p': p, 'q': q},
      'phi': phi
    };
  }

  /// Simple RSA encryption (for small numbers)
  static BigInt rsaEncrypt(int message, int n, int e) {
    return NumberTheory.modularExponentiation(
        BigInt.from(message), BigInt.from(e), BigInt.from(n));
  }

  /// Simple RSA decryption
  static BigInt rsaDecrypt(int ciphertext, int n, int d) {
    return NumberTheory.modularExponentiation(
        BigInt.from(ciphertext), BigInt.from(d), BigInt.from(n));
  }

  /// Caesar cipher (for fun)
  static String caesarCipher(String text, int shift) {
    return text.split('').map((char) {
      if (char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90) {
        // Uppercase
        return String.fromCharCode(
            ((char.codeUnitAt(0) - 65 + shift) % 26) + 65);
      } else if (char.codeUnitAt(0) >= 97 && char.codeUnitAt(0) <= 122) {
        // Lowercase
        return String.fromCharCode(
            ((char.codeUnitAt(0) - 97 + shift) % 26) + 97);
      }
      return char;
    }).join('');
  }

  /// Vigenère cipher
  static String vigenereCipher(String text, String key,
      {bool decrypt = false}) {
    String result = '';
    int keyIndex = 0;

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90) {
        // Uppercase
        int shift = key[keyIndex % key.length].toUpperCase().codeUnitAt(0) - 65;
        if (decrypt) shift = -shift;
        result += String.fromCharCode(
            ((char.codeUnitAt(0) - 65 + shift + 26) % 26) + 65);
        keyIndex++;
      } else if (char.codeUnitAt(0) >= 97 && char.codeUnitAt(0) <= 122) {
        // Lowercase
        int shift = key[keyIndex % key.length].toLowerCase().codeUnitAt(0) - 97;
        if (decrypt) shift = -shift;
        result += String.fromCharCode(
            ((char.codeUnitAt(0) - 97 + shift + 26) % 26) + 97);
        keyIndex++;
      } else {
        result += char;
      }
    }

    return result;
  }

  /// Frequency analysis for cryptanalysis
  static Map<String, double> frequencyAnalysis(String text) {
    Map<String, int> counts = {};
    int totalLetters = 0;

    for (String char in text.toLowerCase().split('')) {
      if (char.codeUnitAt(0) >= 97 && char.codeUnitAt(0) <= 122) {
        counts[char] = (counts[char] ?? 0) + 1;
        totalLetters++;
      }
    }

    Map<String, double> frequencies = {};
    counts.forEach((char, count) {
      frequencies[char] = count / totalLetters;
    });

    return frequencies;
  }

  /// Chi-squared test for randomness
  static double chiSquaredTest(String text) {
    const expectedFrequencies = {
      'a': 0.0817,
      'b': 0.0150,
      'c': 0.0278,
      'd': 0.0425,
      'e': 0.1202,
      'f': 0.0223,
      'g': 0.0202,
      'h': 0.0609,
      'i': 0.0697,
      'j': 0.0015,
      'k': 0.0077,
      'l': 0.0403,
      'm': 0.0241,
      'n': 0.0675,
      'o': 0.0751,
      'p': 0.0193,
      'q': 0.0010,
      'r': 0.0599,
      's': 0.0633,
      't': 0.0906,
      'u': 0.0276,
      'v': 0.0098,
      'w': 0.0236,
      'x': 0.0015,
      'y': 0.0197,
      'z': 0.0007
    };

    Map<String, double> observed = frequencyAnalysis(text);
    double chiSquared = 0.0;

    for (String char in expectedFrequencies.keys) {
      double expected = expectedFrequencies[char]!;
      double observedFreq = observed[char] ?? 0.0;
      chiSquared += math.pow(observedFreq - expected, 2) / expected;
    }

    return chiSquared;
  }
}
