import 'package:curso_flutter_places/utils/app_routes.dart';
import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          ),
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
