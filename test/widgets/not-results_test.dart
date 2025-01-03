import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/widgets/not-results.dart'; // Substitua pelo caminho correto

void main() {
  group('NoResultsWidget', () {
    testWidgets('renders SVG and text', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsWidget(),
          ),
        ),
      );

      // Verifica se o SVG é renderizado
      expect(find.byType(SvgPicture), findsOneWidget);

      // Verifica se o texto "No result found." é renderizado
      expect(find.text('No result found.'), findsOneWidget);
    });
  });
}
