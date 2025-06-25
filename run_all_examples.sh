#!/bin/bash

# Quick runner for all mathematical research examples
# Make sure Dart is in your PATH or update the DART_PATH variable

DART_PATH="/home/chientrm/Documents/flutter/bin/cache/dart-sdk/bin/dart"

echo "=== Mathematical Research with Dart - All Examples ==="
echo

echo "1. Running Main Demo..."
$DART_PATH run bin/main.dart
echo

echo "2. Running Prime Research..."
$DART_PATH run examples/prime_research.dart
echo

echo "3. Running Complex Analysis..."
$DART_PATH run examples/complex_research.dart
echo

echo "4. Running Statistical Research..."
$DART_PATH run examples/statistical_research.dart
echo

echo "5. Running Cryptography Research..."
$DART_PATH run examples/cryptography_research.dart
echo

echo "6. Running Visual Examples..."
$DART_PATH run examples/visual_examples.dart
echo

echo "7. Running Simple Plotter Demo..."
$DART_PATH run lib/simple_plotter.dart
echo

echo "=== All Examples Complete ==="
