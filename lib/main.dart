import 'package:curso_flutter_places/screens/place_form_screen.dart';
import 'package:curso_flutter_places/screens/places_list_screen.dart';
import 'package:curso_flutter_places/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const PlacesListScreen(),
      routes: {
        AppRoutes.placeForm: (ctx) => const PlaceFormScreen(),
      },
    );
  }
}
