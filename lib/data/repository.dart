import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:super_hero/data/model/superhero_response.dart';

class Repository {
  Future<SuperheroResponse?> fetchSuperHeroInfo(String name) async {
    final response = await http.get(
      Uri.parse(
          "https://superheroapi.com/api/f28a4bc7a4eb5b42e74d7d0d96068d23/search/$name")
    );

    if(response. statusCode == 200){
      var decodeJson = jsonDecode(response.body);
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(decodeJson);

      return superheroResponse;

    }else{
      return null;
    }

  }
}
