import 'dart:math' as math;

/// Complex number implementation for mathematical research
class Complex {
  final double real;
  final double imaginary;

  const Complex(this.real, this.imaginary);

  // Named constructors
  const Complex.real(double value)
      : real = value,
        imaginary = 0.0;
  const Complex.imaginary(double value)
      : real = 0.0,
        imaginary = value;
  const Complex.zero()
      : real = 0.0,
        imaginary = 0.0;
  const Complex.one()
      : real = 1.0,
        imaginary = 0.0;
  const Complex.i()
      : real = 0.0,
        imaginary = 1.0;

  /// Create complex number from polar coordinates
  factory Complex.polar(double magnitude, double angle) {
    return Complex(
      magnitude * math.cos(angle),
      magnitude * math.sin(angle),
    );
  }

  // Arithmetic operations
  Complex operator +(Complex other) {
    return Complex(real + other.real, imaginary + other.imaginary);
  }

  Complex operator -(Complex other) {
    return Complex(real - other.real, imaginary - other.imaginary);
  }

  Complex operator *(Complex other) {
    return Complex(
      real * other.real - imaginary * other.imaginary,
      real * other.imaginary + imaginary * other.real,
    );
  }

  Complex operator /(Complex other) {
    double denominator =
        other.real * other.real + other.imaginary * other.imaginary;
    if (denominator == 0) throw ArgumentError('Division by zero');

    return Complex(
      (real * other.real + imaginary * other.imaginary) / denominator,
      (imaginary * other.real - real * other.imaginary) / denominator,
    );
  }

  Complex operator -() => Complex(-real, -imaginary);

  // Properties
  double get magnitude => math.sqrt(real * real + imaginary * imaginary);
  double get magnitudeSquared => real * real + imaginary * imaginary;
  double get argument => math.atan2(imaginary, real);
  Complex get conjugate => Complex(real, -imaginary);

  // Mathematical functions
  Complex get sqrt {
    double r = magnitude;
    double theta = argument;
    double sqrtR = math.sqrt(r);
    return Complex.polar(sqrtR, theta / 2);
  }

  Complex pow(Complex exponent) {
    if (this == const Complex.zero()) {
      if (exponent.real > 0) return const Complex.zero();
      if (exponent.real == 0) return const Complex.one();
      throw ArgumentError('0^(negative power) is undefined');
    }

    double r = magnitude;
    double theta = argument;

    // z^w = r^w * e^(iw*theta) where w = a + bi
    double a = exponent.real;
    double b = exponent.imaginary;

    double logR = math.log(r);
    double rPowA = math.pow(r, a).toDouble();
    double ePowBLogR = math.exp(-b * theta);

    double newMagnitude = rPowA * ePowBLogR;
    double newArgument = a * theta + b * logR;

    return Complex.polar(newMagnitude, newArgument);
  }

  Complex get exp {
    double expReal = math.exp(real);
    return Complex(
      expReal * math.cos(imaginary),
      expReal * math.sin(imaginary),
    );
  }

  Complex get log {
    return Complex(math.log(magnitude), argument);
  }

  Complex get sin {
    double coshImag = (math.exp(imaginary) + math.exp(-imaginary)) / 2;
    double sinhImag = (math.exp(imaginary) - math.exp(-imaginary)) / 2;
    return Complex(
      math.sin(real) * coshImag,
      math.cos(real) * sinhImag,
    );
  }

  Complex get cos {
    double coshImag = (math.exp(imaginary) + math.exp(-imaginary)) / 2;
    double sinhImag = (math.exp(imaginary) - math.exp(-imaginary)) / 2;
    return Complex(
      math.cos(real) * coshImag,
      -math.sin(real) * sinhImag,
    );
  }

  Complex get tan {
    return sin / cos;
  }

  // Utility methods
  bool get isReal => imaginary == 0.0;
  bool get isImaginary => real == 0.0;
  bool get isZero => real == 0.0 && imaginary == 0.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Complex &&
        other.real == real &&
        other.imaginary == imaginary;
  }

  @override
  int get hashCode => Object.hash(real, imaginary);

  @override
  String toString() {
    if (isZero) return '0';
    if (isReal) return real.toString();
    if (isImaginary) {
      if (imaginary == 1.0) return 'i';
      if (imaginary == -1.0) return '-i';
      return '${imaginary}i';
    }

    String imagPart = imaginary > 0 ? '+${imaginary}i' : '${imaginary}i';
    if (imaginary == 1.0) imagPart = '+i';
    if (imaginary == -1.0) imagPart = '-i';

    return '$real$imagPart';
  }

  String toStringPolar() {
    return '${magnitude.toStringAsFixed(6)} * e^(${argument.toStringAsFixed(6)}i)';
  }
}
