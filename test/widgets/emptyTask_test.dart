import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/presentation/screens/task_form_screen.dart';
import 'package:taski/widgets/emptyTask.dart';
import 'package:taski/widgets/create-taskButton.dart';

void main() {
  group('EmptyTaskWidget', () {
    testWidgets('renders SVG, text, and button', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyTaskWidget(),
          ),
        ),
      );

      // Verifica se o SVG é renderizado
      expect(find.byType(SvgPicture), findsOneWidget);

      // Verifica se o texto "You have no task listed." é renderizado
      expect(find.text('You have no task listed.'), findsOneWidget);

      // Verifica se o botão "CreateTaskButton" é renderizado
      expect(find.byType(CreateTaskButton), findsOneWidget);
    });

    testWidgets('displays modal when CreateTaskButton is pressed',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyTaskWidget(),
          ),
        ),
      );

      // Tenta encontrar o botão
      final createTaskButton = find.byType(CreateTaskButton);

      // Certifica-se de que o botão existe
      expect(createTaskButton, findsOneWidget);

      // Pressiona o botão
      await tester.tap(createTaskButton);
      await tester.pumpAndSettle(); // Aguarda o modal abrir

      // Verifica se o modal é exibido
      expect(find.text("What's in your mind?"), findsOneWidget);
      expect(find.byType(TaskFormScreen), findsOneWidget);
    });
  });
}
