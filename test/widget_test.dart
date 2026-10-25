import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_travel_app/main.dart';
import 'package:trivia_travel_app/travel_data.dart';

void main() {
  test('travel guide contains six countries and famous places', () {
    expect(countries.length, 6);
    expect(allPlaces.length, 18);
    expect(countries.any((c) => c.name == 'India'), isTrue);
    expect(allPlaces.any((p) => p.name == 'Taj Mahal'), isTrue);
  });

  testWidgets('discovery screen and saved tab appear', (tester) async {
    await tester.pumpWidget(const TriviaTravelApp());
    expect(find.text('TRIVIA'), findsOneWidget);
    expect(find.text('Explore countries'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
  });
}
