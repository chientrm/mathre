import 'package:mathre/math_utils.dart';
import 'package:mathre/statistics.dart';
import 'package:mathre/number_theory.dart';
import 'package:mathre/complex.dart';

void main() {
  print('=== Mathematical Research with Dart ===\n');

  // Demonstrate basic mathematical operations
  print('1. Basic Mathematical Operations:');
  print('Factorial of 10: ${MathUtils.factorial(10)}');
  print('Fibonacci(20): ${MathUtils.fibonacci(20)}');
  print('Is 97 prime? ${MathUtils.isPrime(97)}');
  print('GCD(48, 18): ${MathUtils.gcd(48, 18)}');
  print('LCM(12, 8): ${MathUtils.lcm(12, 8)}');
  print('Binomial C(10,3): ${MathUtils.binomialCoefficient(10, 3)}');
  print('Cube root of 27: ${MathUtils.nthRoot(27, 3)}');
  print('');

  // Demonstrate prime generation
  print('2. Prime Number Generation:');
  List<int> primes = MathUtils.sieveOfEratosthenes(50);
  print('Primes up to 50: $primes');
  print('Count: ${primes.length}');
  print('');

  // Demonstrate statistics
  print('3. Statistical Analysis:');
  List<double> data = [1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0];
  print('Data: $data');
  print('Mean: ${Statistics.mean(data).toStringAsFixed(3)}');
  print('Median: ${Statistics.median(data).toStringAsFixed(3)}');
  print(
      'Standard Deviation: ${Statistics.standardDeviation(data).toStringAsFixed(3)}');
  print('Variance: ${Statistics.variance(data).toStringAsFixed(3)}');
  print('');

  // Linear regression example
  print('4. Linear Regression:');
  List<double> x = [1, 2, 3, 4, 5];
  List<double> y = [2.1, 4.2, 6.1, 8.2, 10.1];
  var regression = Statistics.linearRegression(x, y);
  print('X: $x');
  print('Y: $y');
  print('Slope: ${regression.slope.toStringAsFixed(3)}');
  print('Intercept: ${regression.intercept.toStringAsFixed(3)}');
  print('Correlation: ${Statistics.correlation(x, y).toStringAsFixed(3)}');
  print('');

  // Number theory demonstrations
  print('5. Number Theory:');
  print('Euler Totient φ(12): ${NumberTheory.eulerTotient(12)}');
  print('Divisors of 24: ${NumberTheory.divisors(24)}');
  print('Sum of divisors of 12: ${NumberTheory.sumOfDivisors(12)}');
  print('Is 28 perfect? ${NumberTheory.isPerfect(28)}');

  Map<int, int> factors = NumberTheory.primeFactorization(60);
  print('Prime factorization of 60: $factors');

  print(
      'Modular exponentiation 3^4 mod 5: ${NumberTheory.modularExponentiation(BigInt.from(3), BigInt.from(4), BigInt.from(5))}');

  var extGcd = NumberTheory.extendedGcd(35, 15);
  print(
      'Extended GCD(35, 15): gcd=${extGcd.gcd}, x=${extGcd.x}, y=${extGcd.y}');

  List<int> collatz = NumberTheory.collatzSequence(7);
  print('Collatz sequence for 7: $collatz');
  print('');

  // Complex number demonstrations
  print('6. Complex Number Operations:');
  Complex z1 = const Complex(3, 4);
  Complex z2 = const Complex(1, -2);

  print('z1 = $z1, |z1| = ${z1.magnitude.toStringAsFixed(3)}');
  print('z2 = $z2, arg(z2) = ${z2.argument.toStringAsFixed(3)}');
  print('z1 + z2 = ${z1 + z2}');
  print('z1 * z2 = ${z1 * z2}');
  print('z1 / z2 = ${z1 / z2}');
  print('z1^2 = ${z1.pow(const Complex.real(2))}');
  print('exp(iπ) = ${Complex.polar(1, 3.14159).exp}');
  print('ln(z1) = ${z1.log}');
  print('sin(z1) = ${z1.sin}');
  print('');

  // Research example: Exploring the Mandelbrot set
  print('7. Mandelbrot Set Research Example:');
  print('Testing points in the complex plane for Mandelbrot set membership:');

  List<Complex> testPoints = [
    const Complex(0, 0),
    const Complex(-1, 0),
    const Complex(0.5, 0.5),
    const Complex(-0.5, 0.6),
    const Complex(1, 1),
  ];

  for (Complex c in testPoints) {
    bool inSet = isMandelbrotMember(c, maxIterations: 100);
    print('c = $c: ${inSet ? "IN" : "OUT"} Mandelbrot set');
  }
  print('');

  print('8. Mathematical Sequences:');
  print('First 15 Fibonacci numbers:');
  for (int i = 0; i < 15; i++) {
    print('F($i) = ${MathUtils.fibonacci(i)}');
  }
}

/// Check if a complex number is in the Mandelbrot set
bool isMandelbrotMember(Complex c, {int maxIterations = 1000}) {
  Complex z = const Complex.zero();

  for (int i = 0; i < maxIterations; i++) {
    if (z.magnitude > 2.0) return false;
    z = z * z + c;
  }

  return true;
}
