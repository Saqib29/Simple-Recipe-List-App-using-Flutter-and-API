import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app_with_api/models/recipe/recipe.dart';

class RecipeApi{

  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', 
    {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "a5b803e08amsh3abe18ed5b25b2cp17090ajsn8c5c85b5b088",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true",
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']){
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }

}