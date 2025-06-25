import 'dart:math' as math;

/// Statistical functions and data analysis utilities
class Statistics {
  /// Calculate the mean of a list of numbers
  static double mean(List<num> data) {
    if (data.isEmpty) {
      throw ArgumentError('Cannot calculate mean of empty list');
    }
    return data.fold(0.0, (sum, x) => sum + x) / data.length;
  }

  /// Calculate the median of a list of numbers
  static double median(List<num> data) {
    if (data.isEmpty) {
      throw ArgumentError('Cannot calculate median of empty list');
    }

    List<num> sorted = List.from(data)..sort();
    int middle = sorted.length ~/ 2;

    if (sorted.length % 2 == 1) {
      return sorted[middle].toDouble();
    } else {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
  }

  /// Calculate the mode of a list of numbers
  static List<num> mode(List<num> data) {
    if (data.isEmpty) {
      throw ArgumentError('Cannot calculate mode of empty list');
    }

    Map<num, int> frequency = {};
    for (num value in data) {
      frequency[value] = (frequency[value] ?? 0) + 1;
    }

    int maxFrequency = frequency.values.reduce(math.max);
    return frequency.keys
        .where((key) => frequency[key] == maxFrequency)
        .toList();
  }

  /// Calculate the variance of a list of numbers
  static double variance(List<num> data, {bool sample = false}) {
    if (data.isEmpty) {
      throw ArgumentError('Cannot calculate variance of empty list');
    }
    if (sample && data.length < 2) {
      throw ArgumentError('Sample variance requires at least 2 data points');
    }

    double m = mean(data);
    double sum = data.fold(0.0, (sum, x) => sum + math.pow(x - m, 2));

    return sum / (data.length - (sample ? 1 : 0));
  }

  /// Calculate the standard deviation of a list of numbers
  static double standardDeviation(List<num> data, {bool sample = false}) {
    return math.sqrt(variance(data, sample: sample));
  }

  /// Calculate the correlation coefficient between two datasets
  static double correlation(List<num> x, List<num> y) {
    if (x.length != y.length) {
      throw ArgumentError('Datasets must have the same length');
    }
    if (x.length < 2) {
      throw ArgumentError('Need at least 2 data points for correlation');
    }

    double meanX = mean(x);
    double meanY = mean(y);
    double stdX = standardDeviation(x);
    double stdY = standardDeviation(y);

    if (stdX == 0 || stdY == 0) return 0.0;

    double covariance = 0.0;
    for (int i = 0; i < x.length; i++) {
      covariance += (x[i] - meanX) * (y[i] - meanY);
    }
    covariance /= x.length;

    return covariance / (stdX * stdY);
  }

  /// Calculate linear regression coefficients (slope and intercept)
  static ({double slope, double intercept}) linearRegression(
      List<num> x, List<num> y) {
    if (x.length != y.length) {
      throw ArgumentError('Datasets must have the same length');
    }
    if (x.length < 2) {
      throw ArgumentError('Need at least 2 data points for regression');
    }

    double meanX = mean(x);
    double meanY = mean(y);

    double numerator = 0.0;
    double denominator = 0.0;

    for (int i = 0; i < x.length; i++) {
      double dx = x[i] - meanX;
      double dy = y[i] - meanY;
      numerator += dx * dy;
      denominator += dx * dx;
    }

    if (denominator == 0) {
      throw ArgumentError('Cannot calculate regression with constant x values');
    }

    double slope = numerator / denominator;
    double intercept = meanY - slope * meanX;

    return (slope: slope, intercept: intercept);
  }

  /// Calculate z-score for a value in a dataset
  static double zScore(num value, List<num> data) {
    double m = mean(data);
    double std = standardDeviation(data);

    if (std == 0) {
      throw ArgumentError(
          'Cannot calculate z-score with zero standard deviation');
    }

    return (value - m) / std;
  }

  /// Calculate percentile of a value in a dataset
  static double percentile(num value, List<num> data) {
    if (data.isEmpty) {
      throw ArgumentError('Cannot calculate percentile of empty list');
    }

    List<num> sorted = List.from(data)..sort();
    int count = sorted.where((x) => x <= value).length;

    return (count / data.length) * 100;
  }
}
