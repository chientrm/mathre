import 'package:mathre/math_utils.dart';
import 'package:mathre/statistics.dart';
import 'package:mathre/complex.dart';
import 'dart:math' as math;
import 'dart:math' show Random;

/// Visual examples and ASCII plotting for mathematical research
void main() {
  print('=== Visual Mathematical Examples ===\n');

  // 1. Prime number distribution visualization
  visualizePrimeDistribution();

  // 2. Fibonacci spiral approximation
  visualizeFibonacciSpiral();

  // 3. Statistical distribution plotting
  visualizeStatisticalDistribution();

  // 4. Mandelbrot set ASCII visualization
  visualizeMandelbrotSet();

  // 5. Function plotting
  visualizeMathematicalFunctions();
}

/// Visualize prime number distribution
void visualizePrimeDistribution() {
  print('1. Prime Number Distribution (up to 100):');
  print('   Each * represents a prime number\n');

  List<int> primes = MathUtils.sieveOfEratosthenes(100);
  Set<int> primeSet = primes.toSet();

  for (int row = 0; row < 10; row++) {
    String line = '${(row * 10).toString().padLeft(2)}: ';
    for (int col = 0; col < 10; col++) {
      int num = row * 10 + col;
      if (num < 2) {
        line += '  ';
      } else if (primeSet.contains(num)) {
        line += '* ';
      } else {
        line += '. ';
      }
    }
    print(line);
  }

  print(
      '\nPrime density: ${primes.length}/100 = ${(primes.length / 100 * 100).toStringAsFixed(1)}%\n');
}

/// Visualize Fibonacci spiral approximation
void visualizeFibonacciSpiral() {
  print('2. Fibonacci Number Growth Pattern:');
  print('   Visual representation of exponential growth\n');

  List<int> fibNumbers = [];
  for (int i = 1; i <= 15; i++) {
    fibNumbers.add(MathUtils.fibonacci(i).toInt());
  }

  // Normalize for display
  int maxFib = fibNumbers.last;
  const int maxWidth = 50;

  for (int i = 0; i < fibNumbers.length; i++) {
    int barLength = (fibNumbers[i] / maxFib * maxWidth).round();
    String bar = '█' * barLength;
    print(
        'F(${(i + 1).toString().padLeft(2)}): ${fibNumbers[i].toString().padLeft(6)} |$bar');
  }

  // Golden ratio approximation
  print('\nGolden Ratio Convergence:');
  for (int i = 2; i < fibNumbers.length; i++) {
    double ratio = fibNumbers[i] / fibNumbers[i - 1];
    print('F(${i + 1})/F($i) = ${ratio.toStringAsFixed(6)}');
  }
  print('Golden Ratio φ = ${((1 + math.sqrt(5)) / 2).toStringAsFixed(6)}\n');
}

/// Visualize statistical distribution
void visualizeStatisticalDistribution() {
  print('3. Statistical Distribution Visualization:');
  print('   Normal distribution approximation using random data\n');

  // Generate random data using simple LCG
  List<double> data = generateNormalData(1000);

  // Create histogram
  Map<String, int> histogram = createHistogram(data, 15);
  int maxCount = histogram.values.reduce(math.max);

  print('Normal Distribution Histogram:');
  histogram.forEach((range, count) {
    int barLength = (count / maxCount * 40).round();
    String bar = '█' * barLength;
    print('${range.padRight(12)}: ${count.toString().padLeft(3)} |$bar');
  });

  print('\nStatistics:');
  print('Mean: ${Statistics.mean(data).toStringAsFixed(3)}');
  print('Std Dev: ${Statistics.standardDeviation(data).toStringAsFixed(3)}');
  print('');
}

/// Visualize Mandelbrot set
void visualizeMandelbrotSet() {
  print('4. Mandelbrot Set Visualization:');
  print('   ASCII representation of the famous fractal\n');

  const int width = 60;
  const int height = 30;
  const double xMin = -2.0;
  const double xMax = 1.0;
  const double yMin = -1.5;
  const double yMax = 1.5;

  for (int row = 0; row < height; row++) {
    String line = '';
    for (int col = 0; col < width; col++) {
      double x = xMin + (col / width) * (xMax - xMin);
      double y = yMax - (row / height) * (yMax - yMin);

      Complex c = Complex(x, y);
      int iterations = mandelbrotIterations(c, maxIterations: 50);

      if (iterations >= 50) {
        line += '██'; // In the set
      } else if (iterations > 25) {
        line += '▓▓'; // Close to set
      } else if (iterations > 10) {
        line += '▒▒'; // Medium distance
      } else if (iterations > 5) {
        line += '░░'; // Far from set
      } else {
        line += '  '; // Very far
      }
    }
    print(line);
  }
  print('');
}

/// Visualize mathematical functions
void visualizeMathematicalFunctions() {
  print('5. Mathematical Function Plots:');
  print('   sin(x), cos(x), and x² visualized\n');

  const int width = 60;
  const int height = 20;
  const double xMin = -math.pi;
  const double xMax = math.pi;

  // Create a 2D grid
  List<List<String>> grid =
      List.generate(height, (i) => List.generate(width, (j) => ' '));

  // Plot functions
  for (int col = 0; col < width; col++) {
    double x = xMin + (col / width) * (xMax - xMin);

    // sin(x)
    double sinY = math.sin(x);
    int sinRow = ((1 - sinY) / 2 * (height - 1)).round().clamp(0, height - 1);
    if (sinRow < height && col < width) grid[sinRow][col] = '·';

    // cos(x)
    double cosY = math.cos(x);
    int cosRow = ((1 - cosY) / 2 * (height - 1)).round().clamp(0, height - 1);
    if (cosRow < height && col < width) {
      grid[cosRow][col] = grid[cosRow][col] == '·' ? '×' : 'o';
    }

    // x²/10 (scaled down)
    double quadY = (x * x) / 10;
    if (quadY <= 2) {
      // Only plot reasonable values
      int quadRow =
          ((2 - quadY) / 2 * (height - 1)).round().clamp(0, height - 1);
      if (quadRow < height && col < width) {
        grid[quadRow][col] = grid[quadRow][col] == ' ' ? '*' : '#';
      }
    }
  }

  // Print the grid
  print('Legend: · = sin(x), o = cos(x), * = x²/10, × = sin∩cos, # = overlap');
  for (int row = 0; row < height; row++) {
    print(grid[row].join());
  }

  // Add axis labels
  print(
      '${''.padLeft(width ~/ 4)}-π${''.padLeft(width ~/ 4)}0${''.padLeft(width ~/ 4)}+π');
  print('');
}

/// Generate normally distributed data using Box-Muller transform
List<double> generateNormalData(int count) {
  List<double> data = [];
  Random random = Random(42); // Fixed seed for reproducibility

  for (int i = 0; i < count; i += 2) {
    double u1 = random.nextDouble();
    double u2 = random.nextDouble();

    double z1 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
    double z2 = math.sqrt(-2 * math.log(u1)) * math.sin(2 * math.pi * u2);

    data.add(z1);
    if (data.length < count) data.add(z2);
  }

  return data.take(count).toList();
}

/// Create histogram for data visualization
Map<String, int> createHistogram(List<double> data, int bins) {
  double min = data.reduce(math.min);
  double max = data.reduce(math.max);
  double binWidth = (max - min) / bins;

  Map<String, int> histogram = {};

  for (int i = 0; i < bins; i++) {
    double start = min + i * binWidth;
    double end = min + (i + 1) * binWidth;
    String range = '[${start.toStringAsFixed(1)}, ${end.toStringAsFixed(1)})';
    histogram[range] = 0;
  }

  for (double value in data) {
    int bin = ((value - min) / binWidth).floor().clamp(0, bins - 1);
    double start = min + bin * binWidth;
    double end = min + (bin + 1) * binWidth;
    String range = '[${start.toStringAsFixed(1)}, ${end.toStringAsFixed(1)})';
    histogram[range] = (histogram[range] ?? 0) + 1;
  }

  return histogram;
}

/// Calculate Mandelbrot iterations
int mandelbrotIterations(Complex c, {int maxIterations = 100}) {
  Complex z = const Complex.zero();

  for (int i = 0; i < maxIterations; i++) {
    if (z.magnitude > 2.0) return i;
    z = z * z + c;
  }

  return maxIterations;
}
