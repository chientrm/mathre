import 'package:test/test.dart';
import 'package:mathre/math_utils.dart';

void main() {
  group('MathUtils Tests', () {
    test('factorial calculation', () {
      expect(MathUtils.factorial(0), equals(BigInt.one));
      expect(MathUtils.factorial(1), equals(BigInt.one));
      expect(MathUtils.factorial(5), equals(BigInt.from(120)));
      expect(MathUtils.factorial(10), equals(BigInt.from(3628800)));
    });

    test('fibonacci calculation', () {
      expect(MathUtils.fibonacci(0), equals(BigInt.zero));
      expect(MathUtils.fibonacci(1), equals(BigInt.one));
      expect(MathUtils.fibonacci(10), equals(BigInt.from(55)));
      expect(MathUtils.fibonacci(20), equals(BigInt.from(6765)));
    });

    test('prime number checking', () {
      expect(MathUtils.isPrime(2), isTrue);
      expect(MathUtils.isPrime(3), isTrue);
      expect(MathUtils.isPrime(17), isTrue);
      expect(MathUtils.isPrime(97), isTrue);
      expect(MathUtils.isPrime(4), isFalse);
      expect(MathUtils.isPrime(15), isFalse);
      expect(MathUtils.isPrime(1), isFalse);
    });

    test('sieve of eratosthenes', () {
      var primes = MathUtils.sieveOfEratosthenes(20);
      expect(primes, equals([2, 3, 5, 7, 11, 13, 17, 19]));
    });

    test('gcd calculation', () {
      expect(MathUtils.gcd(48, 18), equals(6));
      expect(MathUtils.gcd(17, 13), equals(1));
      expect(MathUtils.gcd(100, 25), equals(25));
    });

    test('lcm calculation', () {
      expect(MathUtils.lcm(12, 8), equals(24));
      expect(MathUtils.lcm(15, 25), equals(75));
    });

    test('binomial coefficient', () {
      expect(MathUtils.binomialCoefficient(5, 2), equals(BigInt.from(10)));
      expect(MathUtils.binomialCoefficient(10, 3), equals(BigInt.from(120)));
      expect(MathUtils.binomialCoefficient(0, 0), equals(BigInt.one));
    });

    test('nth root calculation', () {
      expect(MathUtils.nthRoot(27, 3), closeTo(3.0, 0.001));
      expect(MathUtils.nthRoot(16, 4), closeTo(2.0, 0.001));
      expect(MathUtils.nthRoot(100, 2), closeTo(10.0, 0.001));
    });
  });
}
