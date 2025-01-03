import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/widgets/header.dart';

void main() {
  group('HeaderWidget', () {
    testWidgets('renders the icon, text, username, and profile image',
        (WidgetTester tester) async {
      // Configure o widget de teste
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderWidget(),
          ),
        ),
      );

      // Verifica se o ícone é renderizado
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      // Verifica se o texto "Taski" é renderizado
      expect(find.text("Taski"), findsOneWidget);

      // Verifica se o nome do usuário "John" é renderizado
      expect(find.text("John"), findsOneWidget);

      // Verifica se a imagem de perfil é renderizada
      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('applies correct styling to text elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderWidget(),
          ),
        ),
      );

      // Verifica se o estilo do texto "Taski" está correto
      final taskiText = tester.widget<Text>(find.text("Taski"));
      expect(taskiText.style?.fontSize, 16.0);
      expect(taskiText.style?.fontWeight, FontWeight.w400);
      expect(taskiText.style?.color, const Color(0xFF3F3D56));

      // Verifica se o estilo do texto "John" está correto
      final johnText = tester.widget<Text>(find.text("John"));
      expect(johnText.style?.fontSize, 16.0);
      expect(johnText.style?.fontWeight, FontWeight.w600);
      expect(johnText.style?.color, const Color(0xFF3F3D56));
    });
  });
}
