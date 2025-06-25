import 'package:mathre/math_utils.dart';
import 'package:mathre/number_theory.dart';

/// Research example: Study of prime gaps
void main() {
  print('=== Prime Gap Research ===\n');

  // Generate primes up to 1000 and analyze gaps
  List<int> primes = MathUtils.sieveOfEratosthenes(1000);

  print('First 20 primes: ${primes.take(20).toList()}');
  print('Number of primes up to 1000: ${primes.length}');

  // Calculate prime gaps
  List<int> gaps = [];
  for (int i = 1; i < primes.length; i++) {
    gaps.add(primes[i] - primes[i - 1]);
  }

  // Analyze gap distribution
  Map<int, int> gapFrequency = {};
  for (int gap in gaps) {
    gapFrequency[gap] = (gapFrequency[gap] ?? 0) + 1;
  }

  print('\nPrime gap analysis:');
  print('Most common gaps:');
  var sortedGaps = gapFrequency.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  for (var entry in sortedGaps.take(10)) {
    print('Gap ${entry.key}: occurs ${entry.value} times');
  }

  // Find largest gaps
  int maxGap = gaps.reduce((a, b) => a > b ? a : b);
  print('\nLargest prime gap up to 1000: $maxGap');

  // Twin prime research
  print('\n=== Twin Prime Research ===');
  List<({int p1, int p2})> twinPrimes = [];

  for (int i = 0; i < primes.length - 1; i++) {
    if (primes[i + 1] - primes[i] == 2) {
      twinPrimes.add((p1: primes[i], p2: primes[i + 1]));
    }
  }

  print('Twin primes up to 1000:');
  for (var twin in twinPrimes.take(10)) {
    print('(${twin.p1}, ${twin.p2})');
  }
  print('Total twin prime pairs: ${twinPrimes.length}');

  // Sophie Germain primes
  print('\n=== Sophie Germain Prime Research ===');
  List<int> sophieGermainPrimes = [];

  for (int p in primes) {
    if (p < 500 && MathUtils.isPrime(2 * p + 1)) {
      sophieGermainPrimes.add(p);
    }
  }

  print('Sophie Germain primes (p where 2p+1 is also prime):');
  print(sophieGermainPrimes.take(15).toList());

  // Perfect number research
  print('\n=== Perfect Number Research ===');
  List<int> perfectNumbers = [];

  for (int n = 2; n <= 10000; n++) {
    if (NumberTheory.isPerfect(n)) {
      perfectNumbers.add(n);
    }
  }

  print('Perfect numbers up to 10,000:');
  for (int perfect in perfectNumbers) {
    List<int> divisors = NumberTheory.divisors(perfect);
    List<int> properDivisors = divisors.where((d) => d != perfect).toList();
    print('$perfect = ${properDivisors.join(' + ')}');
  }
}
