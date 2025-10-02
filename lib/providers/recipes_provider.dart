import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];

  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();
    // Android 10.0.2.2
    // IOS 127.0.0.1

    final url = Uri.parse(
      'https://dd60ecb2-3be4-4385-b694-11af00abeef4.mock.pstmn.io/recipes',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(
          data['recipes'].map((recipe) => Recipe.fromJSON(recipe)),
        );
      } else {
        print('Error ${response.statusCode}');
        recipes = [];
      }
    } catch (exception) {
      print('Error in request');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
