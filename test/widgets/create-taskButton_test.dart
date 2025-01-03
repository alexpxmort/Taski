import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/widgets/create-taskButton.dart'; // Substitua pelo caminho correto

void main() {
  group('CreateTaskButton', () {
    testWidgets('renders icon and text correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CreateTaskButton(onPress: () {}),
          ),
        ),
      );

      // Verifica se o ícone de adição está presente
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Verifica se o texto "Create task" está presente
      expect(find.text("Create task"), findsOneWidget);
    });

    testWidgets('executes callback when pressed', (WidgetTester tester) async {
      // Variável para verificar se o callback foi chamado
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CreateTaskButton(
              onPress: () {
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Simula um toque no botão
      await tester.tap(find.byType(CreateTaskButton));
      await tester.pumpAndSettle();

      // Verifica se o callback foi chamado
      expect(callbackCalled, isTrue);
    });
  });
}
