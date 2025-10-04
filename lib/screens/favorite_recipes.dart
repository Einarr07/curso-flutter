import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recibe_book/providers/recipes_provider.dart';
import 'package:recibe_book/screens/repice_detail.dart';

import '../models/recipe_model.dart';

class FavoriteRecipes extends StatelessWidget {
  const FavoriteRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Consumer<RecipesProvider>(
        builder: (context, recipeProvider, child) {
          final favoritesRecipes = recipeProvider.favoriteRecipe;
          return favoritesRecipes.isEmpty
              ? Center(child: Text('No favorites recipes'))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final recipe = favoritesRecipes[index];
                    return FavoriteRecipesCard(recipe: recipe);
                  },
                  itemCount: favoritesRecipes.length,
                );
        },
      ),
    );
  }
}

class FavoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;

  const FavoriteRecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipesData: recipe),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(children: [Text(recipe.name), Text(recipe.author)]),
      ),
    );
  }
}
