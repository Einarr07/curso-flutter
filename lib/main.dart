import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recibe_book/l10n/app_localizations.dart';
import 'package:recibe_book/providers/recipes_provider.dart';
import 'package:recibe_book/screens/favorite_recipes.dart';
import 'package:recibe_book/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecipesProvider())],
      child: MaterialApp(
        // idiomas soportados
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Recibe Book',
        home: const RecipeBook(),
      ),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            l10n.appTitle,
            style: const TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: const Icon(Icons.home), text: l10n.home),
              Tab(icon: const Icon(Icons.favorite), text: l10n.favorite),
            ],
          ),
        ),
        body: const TabBarView(children: [HomeScreen(), FavoriteRecipes()]),
      ),
    );
  }
}
