import 'package:mathre/complex.dart';
import 'dart:math' as math;

/// Research example: Exploring fractals with complex numbers
void main() {
  print('=== Complex Analysis & Fractal Research ===\n');

  // Julia Set exploration
  print('1. Julia Set Analysis:');
  Complex c = const Complex(-0.7, 0.27015); // Interesting Julia set parameter

  print('Julia set parameter c = $c');

  // Test some points
  List<Complex> testPoints = [
    const Complex(0, 0),
    const Complex(0.5, 0.5),
    const Complex(-0.5, 0.5),
    const Complex(1, 0),
  ];

  for (Complex z0 in testPoints) {
    int iterations = juliaSetIterations(z0, c);
    String status = iterations >= 100 ? 'IN' : 'OUT';
    print('z₀ = $z0: $status Julia set (iterations: $iterations)');
  }

  // Complex function analysis
  print('\n2. Complex Function Analysis:');

  // Analyze f(z) = z² + c for various c values
  List<Complex> cValues = [
    const Complex(0, 0),
    const Complex(1, 0),
    const Complex(0, 1),
    const Complex(-1, 1),
  ];

  for (Complex c in cValues) {
    print('\nAnalyzing f(z) = z² + $c:');

    // Find some iterations starting from z₀ = 0
    Complex z = const Complex.zero();
    print('  Orbit: z₀ = $z');

    for (int i = 1; i <= 5; i++) {
      z = z * z + c;
      print('  z$i = $z (|z$i| = ${z.magnitude.toStringAsFixed(3)})');
    }

    bool diverges = z.magnitude > 2.0;
    print('  Status: ${diverges ? "Divergent" : "Bounded"}');
  }

  // Root finding with Newton's method for complex functions
  print('\n3. Newton\'s Method for Complex Roots:');

  // Find roots of z³ - 1 = 0
  print('Finding roots of z³ - 1 = 0:');

  List<Complex> startingPoints = [
    const Complex(1, 0),
    const Complex(-0.5, 0.866),
    const Complex(-0.5, -0.866),
    const Complex(0.5, 0.5),
  ];

  for (Complex z0 in startingPoints) {
    Complex root = newtonMethodCubicRoots(z0);
    print('Starting from $z0 → root: $root');

    // Verify it's actually a root
    Complex verification =
        root.pow(const Complex.real(3)) - const Complex.one();
    print(
        '  Verification: z³ - 1 = $verification (magnitude: ${verification.magnitude.toStringAsFixed(6)})');
  }

  // Complex trigonometric identities
  print('\n4. Complex Trigonometric Analysis:');

  List<Complex> angles = [
    Complex.polar(1, math.pi / 4), // 45°
    Complex.polar(1, math.pi / 3), // 60°
    Complex.polar(1, math.pi / 2), // 90°
    Complex.polar(1, math.pi), // 180°
  ];

  for (Complex z in angles) {
    print('\nFor z = $z (polar: ${z.toStringPolar()}):');
    print('  sin(z) = ${z.sin}');
    print('  cos(z) = ${z.cos}');
    print('  tan(z) = ${z.tan}');

    // Verify sin²(z) + cos²(z) = 1
    Complex identity = z.sin * z.sin + z.cos * z.cos;
    print('  sin²(z) + cos²(z) = $identity');
  }

  // Mandelbrot set boundary analysis
  print('\n5. Mandelbrot Set Boundary Analysis:');

  List<Complex> boundaryPoints = [
    const Complex(-0.75, 0), // On real axis
    const Complex(-0.235, 0.827), // Near boundary
    const Complex(0.285, 0.01), // Edge case
    const Complex(-1.25, 0), // Clearly outside
  ];

  for (Complex c in boundaryPoints) {
    int iterations = mandelbrotIterations(c, maxIterations: 1000);
    double ratio = iterations / 1000.0;
    String classification;

    if (iterations >= 1000) {
      classification = 'IN set';
    } else if (iterations > 100) {
      classification = 'Near boundary';
    } else {
      classification = 'Outside';
    }

    print(
        'c = $c: $classification ($iterations iterations, ratio: ${ratio.toStringAsFixed(3)})');
  }
}

/// Calculate Julia set iterations for a point
int juliaSetIterations(Complex z, Complex c, {int maxIterations = 100}) {
  Complex current = z;

  for (int i = 0; i < maxIterations; i++) {
    if (current.magnitude > 2.0) return i;
    current = current * current + c;
  }

  return maxIterations;
}

/// Calculate Mandelbrot set iterations for a point
int mandelbrotIterations(Complex c, {int maxIterations = 100}) {
  Complex z = const Complex.zero();

  for (int i = 0; i < maxIterations; i++) {
    if (z.magnitude > 2.0) return i;
    z = z * z + c;
  }

  return maxIterations;
}

/// Newton's method for finding roots of z³ - 1 = 0
Complex newtonMethodCubicRoots(Complex z0) {
  Complex z = z0;
  const int maxIterations = 20;
  const double tolerance = 1e-10;

  for (int i = 0; i < maxIterations; i++) {
    // f(z) = z³ - 1
    Complex f = z.pow(const Complex.real(3)) - const Complex.one();

    // f'(z) = 3z²
    Complex fPrime = const Complex.real(3) * z * z;

    // Newton step: z_new = z - f(z)/f'(z)
    Complex zNew = z - f / fPrime;

    if ((zNew - z).magnitude < tolerance) {
      return zNew;
    }

    z = zNew;
  }

  return z;
}
