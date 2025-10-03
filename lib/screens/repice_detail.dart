import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recibe_book/providers/recipes_provider.dart';

import '../models/recipe_model.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData;

  const RecipeDetail({super.key, required this.recipesData});

  @override
  _recipeDetailState createState() => _recipeDetailState();
}

class _recipeDetailState extends State<RecipeDetail> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(
      context,
      listen: false,
    ).favoriteRecipe.contains(widget.recipesData);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<RecipesProvider>(
                context,
                listen: false,
              ).toggleFavoriteStatus(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(widget.recipesData.image_link),
            SizedBox(height: 12),
            Text(widget.recipesData.name, style: TextStyle(fontSize: 20)),
            SizedBox(height: 12),
            Text(
              "By: ${widget.recipesData.name}",
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
            Text('Recipes steps: ', style: TextStyle(fontSize: 16)),
            for (var step in widget.recipesData.recipeSteps)
              Align(
                alignment: Alignment.centerLeft,
                child: Text("- $step", style: TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}
