import 'package:flutter/material.dart';
import 'package:recipe_app_with_api/models/recipe/recipe.api.dart';
import 'package:recipe_app_with_api/models/recipe/recipe.dart';
import 'package:recipe_app_with_api/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Recipe> _recipe;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getRecipe();
  }

  Future<void> getRecipe() async {
    _recipe = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
    print(_recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food recipe')
          ],
        ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _recipe.length,
        itemBuilder: (context, index){
          return RecipeCard(title: _recipe[index].name, cookTime: _recipe[index].totalTime, rating: _recipe[index].rating.toString(), thumbnailUrl: _recipe[index].images);
        },
      )
    );
  }
}