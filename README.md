# Mathematical Research with Dart

This project demonstrates Dart's capabilities for mathematical research and computation. It includes implementations of various mathematical functions, statistical analysis tools, number theory algorithms, and complex number operations.

## Features

### 1. Basic Mathematical Operations (`lib/math_utils.dart`)

- **Factorial calculation** with BigInt support for large numbers
- **Fibonacci sequence** generation
- **Prime number checking** and generation using Sieve of Eratosthenes
- **Greatest Common Divisor (GCD)** and **Least Common Multiple (LCM)**
- **Binomial coefficients**
- **nth root calculation** using Newton's method

### 2. Statistical Analysis (`lib/statistics.dart`)

- **Descriptive statistics**: mean, median, mode, variance, standard deviation
- **Correlation analysis** between datasets
- **Linear regression** with slope and intercept calculation
- **Z-score calculation**
- **Percentile calculations**

### 3. Number Theory (`lib/number_theory.dart`)

- **Euler's totient function** φ(n)
- **Divisor generation** and sum of divisors
- **Perfect number detection**
- **Prime factorization**
- **Modular arithmetic**: exponentiation, multiplicative inverse
- **Extended Euclidean algorithm**
- **Collatz sequence** generation
- **Coprimality testing**

### 4. Complex Numbers (`lib/complex.dart`)

- **Complete complex number implementation**
- **Arithmetic operations**: +, -, \*, /
- **Mathematical functions**: exp, log, sin, cos, tan, power
- **Polar and rectangular form conversions**
- **Magnitude and argument calculations**

## Installation and Setup

1. **Install Dart SDK** (if not already installed):

   ```bash
   # On Ubuntu/Debian
   sudo apt-get update
   sudo apt-get install dart

   # On macOS with Homebrew
   brew tap dart-lang/dart
   brew install dart
   ```

2. **Clone or create the project**:

   ```bash
   cd /home/chientrm/Documents/mathre
   ```

3. **Install dependencies**:

   ```bash
   dart pub get
   ```

4. **Run the main demonstration**:

   ```bash
   dart run bin/main.dart
   ```

5. **Run tests**:
   ```bash
   dart test
   ```

## Usage Examples

### Basic Mathematical Operations

```dart
import 'lib/math_utils.dart';

// Calculate large factorials
print(MathUtils.factorial(20)); // 2432902008176640000

// Generate Fibonacci numbers
print(MathUtils.fibonacci(30)); // 832040

// Find prime numbers
List<int> primes = MathUtils.sieveOfEratosthenes(100);
print(primes); // [2, 3, 5, 7, 11, 13, ...]

// Calculate binomial coefficients
print(MathUtils.binomialCoefficient(10, 3)); // 120
```

### Statistical Analysis

```dart
import 'lib/statistics.dart';

List<double> data = [1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0];

print('Mean: ${Statistics.mean(data)}');
print('Standard Deviation: ${Statistics.standardDeviation(data)}');

// Linear regression
List<double> x = [1, 2, 3, 4, 5];
List<double> y = [2.1, 4.2, 6.1, 8.2, 10.1];
var regression = Statistics.linearRegression(x, y);
print('Slope: ${regression.slope}, Intercept: ${regression.intercept}');
```

### Number Theory

```dart
import 'lib/number_theory.dart';

// Euler's totient function
print(NumberTheory.eulerTotient(12)); // 4

// Prime factorization
print(NumberTheory.primeFactorization(60)); // {2: 2, 3: 1, 5: 1}

// Modular exponentiation
print(NumberTheory.modularExponentiation(BigInt.from(3), BigInt.from(4), BigInt.from(5))); // 1

// Collatz sequence
print(NumberTheory.collatzSequence(7)); // [7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]
```

### Complex Numbers

```dart
import 'lib/complex.dart';

Complex z1 = Complex(3, 4);
Complex z2 = Complex(1, -2);

print('z1 + z2 = ${z1 + z2}'); // 4-2i
print('z1 * z2 = ${z1 * z2}'); // 11+2i
print('|z1| = ${z1.magnitude}'); // 5.0
print('exp(iπ) = ${Complex.polar(1, 3.14159).exp}'); // ≈ -1+0i
```

## Research Applications

### 1. Number Theory Research

- **Prime number distribution studies**
- **Modular arithmetic investigations**
- **Perfect number searches**
- **Diophantine equation solving**

### 2. Complex Analysis

- **Mandelbrot set exploration**
- **Julia set generation**
- **Complex function analysis**
- **Fractal mathematics**

### 3. Statistical Modeling

- **Data analysis and regression**
- **Correlation studies**
- **Probability calculations**
- **Hypothesis testing**

### 4. Computational Mathematics

- **Numerical methods implementation**
- **Algorithm complexity analysis**
- **Mathematical sequence studies**
- **Combinatorial calculations**

## Advantages of Dart for Mathematical Research

1. **Performance**: Compiles to native code for excellent computational performance
2. **Precision**: BigInt support for arbitrary precision integer arithmetic
3. **Type Safety**: Strong typing helps prevent mathematical errors
4. **Readability**: Clean, expressive syntax makes complex algorithms understandable
5. **Ecosystem**: Rich package ecosystem for specialized mathematical operations
6. **Cross-platform**: Runs on all major platforms

## Advanced Features

### Custom Mathematical Functions

The project structure allows easy extension with custom mathematical functions:

```dart
// Add to lib/custom_math.dart
class CustomMath {
  static double gamma(double x) {
    // Implement gamma function
  }

  static double bessel(int n, double x) {
    // Implement Bessel functions
  }
}
```

### Symbolic Mathematics

While Dart excels at numerical computation, it can also be used for symbolic mathematics with appropriate libraries or custom implementations.

### Parallel Computing

Dart's isolate system allows for parallel mathematical computations:

```dart
import 'dart:isolate';

Future<List<int>> parallelPrimeGeneration(int limit) async {
  // Implement parallel prime generation
}
```

## Contributing

This is a research-oriented project. Feel free to:

- Add new mathematical functions
- Implement additional number theory algorithms
- Create visualization tools
- Add performance optimizations
- Write comprehensive tests

## License

This project is designed for educational and research purposes. Feel free to use and modify as needed for your mathematical research.
