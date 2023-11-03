// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pokemon_map/main.dart';

import 'mocks/mock_login_repository.dart';
import 'mocks/mock_pokemon_repository.dart';

@GenerateMocks([])
void main() {
  group('end-to-end test', () {
    setUpAll(() async {
      PackageInfo.setMockInitialValues(
          appName: "abc",
          packageName: "com.example.example",
          version: "1.0.0",
          buildNumber: "2",
          buildSignature: "buildSignature");
    });

    testWidgets('test login', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(
        loginRepository: MockLoginRepository(),
        pokemonRepository: MockPokemonRepository(),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Sign up with email
      await tester.tap(find.text('Sign up').first);
      await tester.pumpAndSettle();

      for (var element in mockPokemons) {
        // Find the pokemon in the list
        expect(find.text(element.name), findsOneWidget);
      }

      // Switch to about screen
      await tester.tap(find.byKey(const Key('aboutButton')));
      await tester.pumpAndSettle();

      expect(find.text('Josip Domazet'), findsOneWidget);
      expect(find.text('Skills: Mobile Development & Flutter'), findsOneWidget);
      expect(find.text("App Version: 1.0.0"), findsOneWidget);
    });
  });
}
