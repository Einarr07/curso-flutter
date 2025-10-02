import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recibe_book/providers/recipes_provider.dart';
import 'package:recibe_book/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecipesProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola mundo',
        home: RecipeBook(),
      ),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Recipe Book', style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [Tab(icon: Icon(Icons.home), text: 'Home')],
          ),
        ),
        body: TabBarView(children: [HomeScreen()]),
      ),
    );
  }
}
