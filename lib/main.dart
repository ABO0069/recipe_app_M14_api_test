import 'package:flutter/material.dart';
import 'dart:convert';
void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Viewer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const RecipeListScreen(),
    );
  }
}

class Recipe {
  final int id;
  final String title;
  final String description;
  final int calories;
  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.calories,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      calories: json['calories'] as int,
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});
  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final String jsonString = '''
  [
    {
      "id": 1,
      "title": "Chicken Biryani",
      "description": "Aromatic basmati rice cooked with spiced chicken.",
      "calories": 550
    },
    {
      "id": 2,
      "title": "Beef Curry",
      "description": "Slow-cooked beef in a rich curry gravy.",
      "calories": 620
    },
    {
      "id": 3,
      "title": "Vegetable Khichuri",
      "description": "Rice and lentils cooked with mixed vegetables.",
      "calories": 400
    },
    {
      "id": 4,
      "title": "Pasta Alfredo",
      "description": "Creamy white sauce pasta with parmesan cheese.",
      "calories": 480
    },
    {
      "id": 5,
      "title": "Grilled Sandwich",
      "description": "Toasted sandwich filled with cheese and vegetables.",
      "calories": 310
    },
    {
      "id": 6,
      "title": "Chicken Fry",
      "description": "Crispy deep-fried chicken with spices.",
      "calories": 530
    },
    {
      "id": 7,
      "title": "Egg Curry",
      "description": "Boiled eggs cooked in masala gravy.",
      "calories": 450
    },
    {
      "id": 8,
      "title": "Fruit Salad",
      "description": "Mixed seasonal fruits served chilled.",
      "calories": 250
    },
    {
      "id": 9,
      "title": "Fried Rice",
      "description": "Rice fried with vegetables, egg, and soy sauce.",
      "calories": 500
    },
    {
      "id": 10,
      "title": "Mango Lassi",
      "description": "Sweet yogurt drink blended with ripe mango.",
      "calories": 300
    }
  ]
  ''';

  List<Recipe> recipes = [];
  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }
  void _loadRecipes() {
    final List<dynamic> decodedJson = jsonDecode(jsonString);
    setState(() {
      recipes = decodedJson.map((json) => Recipe.fromJson(json)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                child: Text(
                  recipe.id.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                recipe.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(recipe.description),
              trailing: Text(
                '${recipe.calories} cal',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}