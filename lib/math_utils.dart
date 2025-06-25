import 'dart:math' as math;

/// Basic mathematical operations and utilities
class MathUtils {
  /// Calculate factorial using BigInt for large numbers
  static BigInt factorial(int n) {
    if (n < 0) {
      throw ArgumentError('Factorial is not defined for negative numbers');
    }
    if (n <= 1) return BigInt.one;

    BigInt result = BigInt.one;
    for (int i = 2; i <= n; i++) {
      result *= BigInt.from(i);
    }
    return result;
  }

  /// Calculate the nth Fibonacci number
  static BigInt fibonacci(int n) {
    if (n < 0) {
      throw ArgumentError('Fibonacci is not defined for negative numbers');
    }
    if (n <= 1) return BigInt.from(n);

    BigInt a = BigInt.zero;
    BigInt b = BigInt.one;

    for (int i = 2; i <= n; i++) {
      BigInt temp = a + b;
      a = b;
      b = temp;
    }
    return b;
  }

  /// Check if a number is prime
  static bool isPrime(int n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }

  /// Generate prime numbers up to n using Sieve of Eratosthenes
  static List<int> sieveOfEratosthenes(int n) {
    if (n < 2) return [];

    List<bool> isPrime = List.filled(n + 1, true);
    isPrime[0] = isPrime[1] = false;

    for (int i = 2; i * i <= n; i++) {
      if (isPrime[i]) {
        for (int j = i * i; j <= n; j += i) {
          isPrime[j] = false;
        }
      }
    }

    return [
      for (int i = 2; i <= n; i++)
        if (isPrime[i]) i
    ];
  }

  /// Calculate the greatest common divisor using Euclidean algorithm
  static int gcd(int a, int b) {
    a = a.abs();
    b = b.abs();
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  /// Calculate the least common multiple
  static int lcm(int a, int b) {
    return (a * b).abs() ~/ gcd(a, b);
  }

  /// Calculate binomial coefficient C(n, k)
  static BigInt binomialCoefficient(int n, int k) {
    if (k > n || k < 0) return BigInt.zero;
    if (k == 0 || k == n) return BigInt.one;

    k = math.min(k, n - k); // Take advantage of symmetry

    BigInt result = BigInt.one;
    for (int i = 0; i < k; i++) {
      result = result * BigInt.from(n - i) ~/ BigInt.from(i + 1);
    }
    return result;
  }

  /// Calculate the nth root of a number using Newton's method
  static double nthRoot(double number, int n) {
    if (n == 0) throw ArgumentError('Root degree cannot be zero');
    if (n == 1) return number;
    if (number < 0 && n % 2 == 0) {
      throw ArgumentError('Even root of negative number is not real');
    }

    double x = number;
    double epsilon = 1e-15;

    while (true) {
      double x1 = ((n - 1) * x + number / math.pow(x, n - 1)) / n;
      if ((x1 - x).abs() < epsilon) break;
      x = x1;
    }

    return x;
  }
}
