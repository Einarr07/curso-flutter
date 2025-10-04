class Recipe {
  int id;
  String name;
  String author;
  String image_link;
  List<String> recipeSteps;

  Recipe({
    required this.id,
    required this.name,
    required this.author,
    required this.image_link,
    required this.recipeSteps,
  });

  factory Recipe.fromJSON(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      image_link: json['image_link'],
      recipeSteps: List<String>.from(json['recipe']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'image_link': image_link,
      'recipe': recipeSteps,
    };
  }

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, author: $author, image_link: $image_link, recipe: $recipeSteps}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipe && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
