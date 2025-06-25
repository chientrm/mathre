/// Number theory functions for mathematical research
class NumberTheory {
  /// Calculate Euler's totient function φ(n)
  static int eulerTotient(int n) {
    if (n <= 0) throw ArgumentError('n must be positive');

    int result = n;

    // Check for factor 2
    if (n % 2 == 0) {
      while (n % 2 == 0) {
        n ~/= 2;
      }
      result -= result ~/ 2;
    }

    // Check for odd factors
    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) {
        while (n % i == 0) {
          n ~/= i;
        }
        result -= result ~/ i;
      }
    }

    // If n is still > 1, then it's a prime
    if (n > 2) result -= result ~/ n;

    return result;
  }

  /// Generate divisors of a number
  static List<int> divisors(int n) {
    if (n <= 0) throw ArgumentError('n must be positive');

    List<int> divisors = [];
    for (int i = 1; i * i <= n; i++) {
      if (n % i == 0) {
        divisors.add(i);
        if (i != n ~/ i) {
          divisors.add(n ~/ i);
        }
      }
    }
    divisors.sort();
    return divisors;
  }

  /// Calculate the sum of divisors (sigma function)
  static int sumOfDivisors(int n) {
    return divisors(n).fold(0, (sum, d) => sum + d);
  }

  /// Check if a number is perfect (equals sum of its proper divisors)
  static bool isPerfect(int n) {
    if (n <= 1) return false;
    int sum = divisors(n).fold(0, (sum, d) => sum + d) - n; // proper divisors
    return sum == n;
  }

  /// Generate prime factorization
  static Map<int, int> primeFactorization(int n) {
    if (n <= 0) throw ArgumentError('n must be positive');

    Map<int, int> factors = {};

    // Handle factor 2
    while (n % 2 == 0) {
      factors[2] = (factors[2] ?? 0) + 1;
      n ~/= 2;
    }

    // Handle odd factors
    for (int i = 3; i * i <= n; i += 2) {
      while (n % i == 0) {
        factors[i] = (factors[i] ?? 0) + 1;
        n ~/= i;
      }
    }

    // If n is still > 2, it's a prime
    if (n > 2) factors[n] = 1;

    return factors;
  }

  /// Calculate modular exponentiation: (base^exp) mod m
  static BigInt modularExponentiation(BigInt base, BigInt exp, BigInt mod) {
    if (mod == BigInt.one) return BigInt.zero;

    BigInt result = BigInt.one;
    base = base % mod;

    while (exp > BigInt.zero) {
      if (exp % BigInt.two == BigInt.one) {
        result = (result * base) % mod;
      }
      exp = exp >> 1;
      base = (base * base) % mod;
    }

    return result;
  }

  /// Extended Euclidean Algorithm
  static ({int gcd, int x, int y}) extendedGcd(int a, int b) {
    if (b == 0) {
      return (gcd: a, x: 1, y: 0);
    }

    var result = extendedGcd(b, a % b);
    int x = result.y;
    int y = result.x - (a ~/ b) * result.y;

    return (gcd: result.gcd, x: x, y: y);
  }

  /// Calculate modular multiplicative inverse
  static int? modularInverse(int a, int m) {
    var result = extendedGcd(a, m);
    if (result.gcd != 1) return null; // Inverse doesn't exist

    return (result.x % m + m) % m;
  }

  /// Check if two numbers are coprime
  static bool areCoprime(int a, int b) {
    return gcd(a, b) == 1;
  }

  /// Calculate the greatest common divisor
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

  /// Generate Collatz sequence
  static List<int> collatzSequence(int n) {
    if (n <= 0) throw ArgumentError('n must be positive');

    List<int> sequence = [n];

    while (n != 1) {
      if (n % 2 == 0) {
        n ~/= 2;
      } else {
        n = 3 * n + 1;
      }
      sequence.add(n);
    }

    return sequence;
  }

  /// Check if a number is a power of another number
  static bool isPowerOf(int n, int base) {
    if (base <= 1 || n <= 0) return false;
    if (n == 1) return true;

    while (n > 1) {
      if (n % base != 0) return false;
      n ~/= base;
    }
    return true;
  }
}
