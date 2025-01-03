import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/app/app.dart';
import 'package:taski/data/database/database_helper.dart';
import 'package:taski/presentation/screens/home_screen.dart';

void main() {
  testWidgets('Test TaskiApp bottom navigation and screen switching',
      (WidgetTester tester) async {
    DatabaseHelper.initializeDatabaseFactory();

    // Build the app
    await tester.pumpWidget(ProviderScope(child: const TaskiApp()));

    // Verify that the initial screen is HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
