// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_weather/frontend/weather_page.dart';

// import 'package:project_weather/main.dart';

void main() {
  test('WeatherService returns valid data', () async {
    final weatherService = WeatherPage();
    final result = await weatherService.getData();

    expect(result, isNotEmpty);
  });
}