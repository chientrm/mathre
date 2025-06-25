import 'dart:math' as math;

/// Simple ASCII plotting utilities for mathematical visualization
class SimplePlotter {
  /// Plot a simple bar chart
  static void barChart(Map<String, num> data,
      {int maxWidth = 50, String title = ''}) {
    if (title.isNotEmpty) {
      print(title);
      print('=' * title.length);
    }

    num maxValue =
        data.values.isEmpty ? 1 : data.values.reduce((a, b) => a > b ? a : b);

    data.forEach((label, value) {
      int barLength = maxValue > 0 ? (value / maxValue * maxWidth).round() : 0;
      String bar = '█' * barLength;
      print('${label.padRight(12)}: ${value.toString().padLeft(8)} |$bar');
    });
    print('');
  }

  /// Plot a line chart using ASCII characters
  static void lineChart(List<double> yValues,
      {int width = 60,
      int height = 20,
      String title = '',
      double? xMin,
      double? xMax,
      double? yMin,
      double? yMax}) {
    if (title.isNotEmpty) {
      print(title);
      print('=' * title.length);
    }

    if (yValues.isEmpty) return;

    // Calculate bounds
    yMin ??= yValues.reduce(math.min);
    yMax ??= yValues.reduce(math.max);
    xMin ??= 0.0;
    xMax ??= yValues.length.toDouble() - 1;

    // Create grid
    List<List<String>> grid =
        List.generate(height, (i) => List.generate(width, (j) => ' '));

    // Plot points
    for (int i = 0; i < yValues.length && i < width; i++) {
      double normalizedX = i / (yValues.length - 1);
      int col = (normalizedX * (width - 1)).round();

      double normalizedY = (yMax - yValues[i]) / (yMax - yMin);
      int row = (normalizedY * (height - 1)).round().clamp(0, height - 1);

      if (row < height && col < width) {
        grid[row][col] = '•';
      }
    }

    // Print grid with y-axis labels
    for (int row = 0; row < height; row++) {
      double yValue = yMax - (row / (height - 1)) * (yMax - yMin);
      String yLabel = yValue.toStringAsFixed(1).padLeft(6);
      print('$yLabel |${grid[row].join('')}');
    }

    // Print x-axis
    print('       ' + '-' * width);
    String xAxisLabels = '       ${xMin.toStringAsFixed(1)}';
    xAxisLabels += ' ' *
        (width -
            xMin.toStringAsFixed(1).length -
            xMax.toStringAsFixed(1).length);
    xAxisLabels += xMax.toStringAsFixed(1);
    print(xAxisLabels);
    print('');
  }

  /// Create a scatter plot
  static void scatterPlot(List<double> xValues, List<double> yValues,
      {int width = 60,
      int height = 20,
      String title = '',
      String symbol = '•'}) {
    if (title.isNotEmpty) {
      print(title);
      print('=' * title.length);
    }

    if (xValues.length != yValues.length || xValues.isEmpty) {
      print('Error: x and y values must have the same non-zero length');
      return;
    }

    double xMin = xValues.reduce(math.min);
    double xMax = xValues.reduce(math.max);
    double yMin = yValues.reduce(math.min);
    double yMax = yValues.reduce(math.max);

    // Create grid
    List<List<String>> grid =
        List.generate(height, (i) => List.generate(width, (j) => ' '));

    // Plot points
    for (int i = 0; i < xValues.length; i++) {
      double normalizedX = (xValues[i] - xMin) / (xMax - xMin);
      double normalizedY = (yMax - yValues[i]) / (yMax - yMin);

      int col = (normalizedX * (width - 1)).round().clamp(0, width - 1);
      int row = (normalizedY * (height - 1)).round().clamp(0, height - 1);

      grid[row][col] = symbol;
    }

    // Print grid with labels
    for (int row = 0; row < height; row++) {
      double yValue = yMax - (row / (height - 1)) * (yMax - yMin);
      String yLabel = yValue.toStringAsFixed(1).padLeft(6);
      print('$yLabel |${grid[row].join('')}');
    }

    // Print x-axis
    print('       ' + '-' * width);
    String xAxisLabels = '       ${xMin.toStringAsFixed(1)}';
    xAxisLabels += ' ' *
        (width -
            xMin.toStringAsFixed(1).length -
            xMax.toStringAsFixed(1).length);
    xAxisLabels += xMax.toStringAsFixed(1);
    print(xAxisLabels);
    print('');
  }

  /// Create a histogram
  static void histogram(List<double> data, {int bins = 10, String title = ''}) {
    if (title.isNotEmpty) {
      print(title);
      print('=' * title.length);
    }

    if (data.isEmpty) return;

    double min = data.reduce(math.min);
    double max = data.reduce(math.max);
    double binWidth = (max - min) / bins;

    List<int> counts = List.filled(bins, 0);

    for (double value in data) {
      int bin = ((value - min) / binWidth).floor().clamp(0, bins - 1);
      counts[bin]++;
    }

    int maxCount = counts.reduce(math.max);
    const int maxBarWidth = 40;

    for (int i = 0; i < bins; i++) {
      double binStart = min + i * binWidth;
      double binEnd = min + (i + 1) * binWidth;
      int barLength =
          maxCount > 0 ? (counts[i] / maxCount * maxBarWidth).round() : 0;
      String bar = '█' * barLength;

      String range =
          '[${binStart.toStringAsFixed(1)}, ${binEnd.toStringAsFixed(1)})';
      print('${range.padRight(12)}: ${counts[i].toString().padLeft(3)} |$bar');
    }
    print('');
  }
}

/// Example usage of the plotting utilities
void main() {
  print('=== Simple Plotting Examples ===\n');

  // Example 1: Bar chart of prime counts by decade
  Map<String, int> primeCounts = {
    '0-9': 4, // 2, 3, 5, 7
    '10-19': 4, // 11, 13, 17, 19
    '20-29': 2, // 23, 29
    '30-39': 2, // 31, 37
    '40-49': 3, // 41, 43, 47
    '50-59': 2, // 53, 59
    '60-69': 2, // 61, 67
    '70-79': 3, // 71, 73, 79
    '80-89': 2, // 83, 89
    '90-99': 1, // 97
  };

  SimplePlotter.barChart(primeCounts.map((k, v) => MapEntry(k, v as num)),
      title: 'Prime Number Distribution by Decade (0-99)');

  // Example 2: Line chart of quadratic function
  List<double> quadratic = [];
  for (int i = -10; i <= 10; i++) {
    quadratic.add((i * i).toDouble());
  }

  SimplePlotter.lineChart(quadratic,
      title: 'Quadratic Function: y = x²', xMin: -10, xMax: 10);

  // Example 3: Scatter plot of sine function
  List<double> xValues = [];
  List<double> sinValues = [];

  for (int i = 0; i <= 50; i++) {
    double x = i * math.pi / 25; // 0 to 2π
    xValues.add(x);
    sinValues.add(math.sin(x));
  }

  SimplePlotter.scatterPlot(xValues, sinValues,
      title: 'Sine Function: y = sin(x)', symbol: '•');

  // Example 4: Histogram of random data
  List<double> randomData = [];
  var random = math.Random(42);

  // Generate some normally distributed data using Box-Muller
  for (int i = 0; i < 1000; i += 2) {
    double u1 = random.nextDouble();
    double u2 = random.nextDouble();

    double z1 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
    double z2 = math.sqrt(-2 * math.log(u1)) * math.sin(2 * math.pi * u2);

    randomData.add(z1);
    if (randomData.length < 500) randomData.add(z2);
  }

  SimplePlotter.histogram(randomData.take(500).toList(),
      bins: 15, title: 'Normal Distribution Histogram');
}
