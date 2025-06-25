import 'package:mathre/statistics.dart';
import 'package:mathre/math_utils.dart';
import 'dart:math' as math;

/// Research example: Statistical analysis of mathematical sequences
void main() {
  print('=== Statistical Analysis of Mathematical Sequences ===\n');

  // 1. Fibonacci number digit analysis
  print('1. Fibonacci Number Analysis:');

  List<BigInt> fibNumbers = [];
  for (int i = 1; i <= 50; i++) {
    fibNumbers.add(MathUtils.fibonacci(i));
  }

  // Analyze last digits of Fibonacci numbers
  List<int> lastDigits =
      fibNumbers.map((f) => int.parse(f.toString().split('').last)).toList();

  print('Last digits of first 50 Fibonacci numbers:');
  print(lastDigits);

  // Statistical analysis of last digits
  Map<int, int> digitFrequency = {};
  for (int digit in lastDigits) {
    digitFrequency[digit] = (digitFrequency[digit] ?? 0) + 1;
  }

  print('\nDigit frequency analysis:');
  for (int digit = 0; digit <= 9; digit++) {
    int count = digitFrequency[digit] ?? 0;
    double percentage = (count / lastDigits.length) * 100;
    print(
        'Digit $digit: $count occurrences (${percentage.toStringAsFixed(1)}%)');
  }

  // 2. Prime gap statistical analysis
  print('\n2. Prime Gap Statistical Analysis:');

  List<int> primes = MathUtils.sieveOfEratosthenes(1000);
  List<int> gaps = [];

  for (int i = 1; i < primes.length; i++) {
    gaps.add(primes[i] - primes[i - 1]);
  }

  List<double> gapsDouble = gaps.map((g) => g.toDouble()).toList();

  print('Prime gaps statistics:');
  print('Mean gap: ${Statistics.mean(gapsDouble).toStringAsFixed(3)}');
  print('Median gap: ${Statistics.median(gapsDouble).toStringAsFixed(3)}');
  print(
      'Standard deviation: ${Statistics.standardDeviation(gapsDouble).toStringAsFixed(3)}');
  print('Most common gaps: ${Statistics.mode(gapsDouble)}');

  // 3. Random number generator quality test
  print('\n3. Pseudo-Random Number Analysis:');

  // Generate pseudo-random numbers using Linear Congruential Generator
  List<double> randomNumbers = generateLCGSequence(1000, seed: 12345);

  print('Statistical tests on 1000 pseudo-random numbers:');
  print(
      'Mean: ${Statistics.mean(randomNumbers).toStringAsFixed(6)} (expected ~0.5)');
  print(
      'Standard deviation: ${Statistics.standardDeviation(randomNumbers).toStringAsFixed(6)} (expected ~0.289)');

  // Chi-square test for uniformity
  double chiSquare = chiSquareUniformityTest(randomNumbers);
  print(
      'Chi-square statistic: ${chiSquare.toStringAsFixed(3)} (df=9, critical value ≈ 16.92 at α=0.05)');

  // 4. Monte Carlo estimation of π
  print('\n4. Monte Carlo Estimation of π:');

  List<int> samples = [1000, 10000, 100000];

  for (int n in samples) {
    double piEstimate = monteCarloPI(n, seed: 42);
    double error = (piEstimate - math.pi).abs();
    double errorPercentage = (error / math.pi) * 100;

    print(
        'n = $n: π ≈ ${piEstimate.toStringAsFixed(6)}, error = ${error.toStringAsFixed(6)} (${errorPercentage.toStringAsFixed(3)}%)');
  }

  // 5. Central Limit Theorem demonstration
  print('\n5. Central Limit Theorem Demonstration:');

  // Generate samples from uniform distribution and look at sample means
  List<double> sampleMeans = [];
  const int numSamples = 1000;
  const int sampleSize = 30;

  for (int i = 0; i < numSamples; i++) {
    List<double> sample = generateLCGSequence(sampleSize, seed: i * 123);
    sampleMeans.add(Statistics.mean(sample));
  }

  print('Distribution of sample means (n=$sampleSize, samples=$numSamples):');
  print(
      'Mean of sample means: ${Statistics.mean(sampleMeans).toStringAsFixed(6)} (expected ~0.5)');
  print(
      'Standard deviation: ${Statistics.standardDeviation(sampleMeans).toStringAsFixed(6)} (expected ~${(1 / math.sqrt(12 * sampleSize)).toStringAsFixed(6)})');

  // Create histogram
  Map<String, int> histogram = createHistogram(sampleMeans);
  print('\nHistogram of sample means:');
  histogram.forEach((range, count) {
    String bar = '*' * (count ~/ 10); // Scale down for display
    print('$range: $count $bar');
  });

  // 6. Correlation analysis of mathematical sequences
  print('\n6. Sequence Correlation Analysis:');

  // Compare Fibonacci numbers with their indices
  List<double> indices = List.generate(20, (i) => (i + 1).toDouble());
  List<double> fibValues =
      List.generate(20, (i) => MathUtils.fibonacci(i + 1).toDouble());

  double correlation =
      Statistics.correlation(indices, fibValues.map(math.log).toList());
  print(
      'Correlation between index and log(Fibonacci): ${correlation.toStringAsFixed(6)}');

  // Linear regression on log-transformed data
  var regression =
      Statistics.linearRegression(indices, fibValues.map(math.log).toList());
  print(
      'Log-linear regression: log(F_n) ≈ ${regression.slope.toStringAsFixed(6)} * n + ${regression.intercept.toStringAsFixed(6)}');
  print(
      'Golden ratio approximation: ${math.exp(regression.slope).toStringAsFixed(6)} (actual: ${((1 + math.sqrt(5)) / 2).toStringAsFixed(6)})');
}

/// Generate sequence using Linear Congruential Generator
List<double> generateLCGSequence(int count, {int seed = 1}) {
  List<double> sequence = [];
  int current = seed;
  const int a = 1664525;
  const int c = 1013904223;
  const int m = 1 << 32; // 2^32

  for (int i = 0; i < count; i++) {
    current = (a * current + c) % m;
    sequence.add(current / m); // Normalize to [0, 1)
  }

  return sequence;
}

/// Chi-square test for uniformity
double chiSquareUniformityTest(List<double> data, {int bins = 10}) {
  List<int> observed = List.filled(bins, 0);
  double expected = data.length / bins;

  for (double value in data) {
    int bin = (value * bins).floor();
    if (bin >= bins) bin = bins - 1; // Handle edge case
    observed[bin]++;
  }

  double chiSquare = 0.0;
  for (int i = 0; i < bins; i++) {
    double diff = observed[i] - expected;
    chiSquare += (diff * diff) / expected;
  }

  return chiSquare;
}

/// Monte Carlo estimation of π
double monteCarloPI(int samples, {int seed = 1}) {
  List<double> randomX = generateLCGSequence(samples, seed: seed);
  List<double> randomY = generateLCGSequence(samples, seed: seed * 2);

  int insideCircle = 0;

  for (int i = 0; i < samples; i++) {
    double x = randomX[i] * 2 - 1; // Convert to [-1, 1]
    double y = randomY[i] * 2 - 1; // Convert to [-1, 1]

    if (x * x + y * y <= 1.0) {
      insideCircle++;
    }
  }

  return 4.0 * insideCircle / samples;
}

/// Create histogram for visualization
Map<String, int> createHistogram(List<double> data, {int bins = 10}) {
  double min = data.reduce(math.min);
  double max = data.reduce(math.max);
  double binWidth = (max - min) / bins;

  Map<String, int> histogram = {};

  for (int i = 0; i < bins; i++) {
    double start = min + i * binWidth;
    double end = min + (i + 1) * binWidth;
    String range = '[${start.toStringAsFixed(3)}, ${end.toStringAsFixed(3)})';
    histogram[range] = 0;
  }

  for (double value in data) {
    int bin = ((value - min) / binWidth).floor();
    if (bin >= bins) bin = bins - 1;

    double start = min + bin * binWidth;
    double end = min + (bin + 1) * binWidth;
    String range = '[${start.toStringAsFixed(3)}, ${end.toStringAsFixed(3)})';
    histogram[range] = (histogram[range] ?? 0) + 1;
  }

  return histogram;
}
