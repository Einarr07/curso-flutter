import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recibe_book/providers/recipes_provider.dart';
import 'package:recibe_book/screens/repice_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(
      context,
      listen: false,
    );
    recipesProvider.fetchRecipes();

    return Scaffold(
      body: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.recipes.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return _recipesCard(context, provider.recipes[index]);
              },
              itemCount: provider.recipes!.length,
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        color: Colors.white,
        child: RecipeFrom(),
      ),
    );
  }

  Widget _recipesCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipeName: recipe.name),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(recipe.image_link, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 4),
                    Container(height: 1, width: 75, color: Colors.orange),
                    Text(
                      'By: ${recipe.author}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeFrom extends StatelessWidget {
  const RecipeFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeImage = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Recipe',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontFamily: 'Arial',
              ),
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _recipeName,
              label: 'Recipe Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the recipe name';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _recipeAuthor,
              label: 'Author',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the author';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _recipeImage,
              label: 'Image URL',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image url';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _recipeDescription,
              label: 'Description',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              },
              maxLines: 4,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget personal
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'Arial', color: Colors.orange),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }
}
