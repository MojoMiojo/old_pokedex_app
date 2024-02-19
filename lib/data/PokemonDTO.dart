import 'package:pokedex_app/data/PokemonAttributesDTO.dart';

class PokemonDTO {
  String name;
  String url;
  PokemonAttributesDTO attributes;
  //final _apiController = PokemonApi();

  PokemonDTO.map(Map<String, dynamic> json) {
    this.name = json['name'];
    this.url = json['url'];
    //this.attributes =
  } //end construtor

} //end PokemonDTO
