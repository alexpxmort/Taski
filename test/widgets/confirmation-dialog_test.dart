import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/widgets/confirmation-dialog.dart';

void main() {
  testWidgets('ConfirmationDialog shows and responds correctly',
      (WidgetTester tester) async {
    // Build the widget tree with a scaffold to show the dialog
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                // Trigger the ConfirmationDialog
                await ConfirmationDialog.show(
                  tester.element(find.byType(ElevatedButton)),
                  title: 'Delete Item',
                  content: 'Are you sure you want to delete this item?',
                  item: 'Item 1', // Ensure this is passed
                );
              },
              child: Text('Show Confirmation Dialog'),
            ),
          ),
        ),
      ),
    );

    // Tap the 'Show Confirmation Dialog' button
    await tester.tap(find.text('Show Confirmation Dialog'));
    await tester.pumpAndSettle();

    // Verify the dialog appears
    expect(find.text('Delete Item'), findsOneWidget);
    expect(find.text('Are you sure you want to delete this item?'),
        findsOneWidget);

    // Verify the buttons are present
    expect(find.text('Cancelar'), findsOneWidget);
    expect(find.text('Confirmar'), findsOneWidget);
  });
}
