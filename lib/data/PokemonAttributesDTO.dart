import 'package:pokedex_app/data/PokemonTypeDTO.dart';

class PokemonAttributesDTO {
  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  List<PokemonTypeDTO> types;
  String sprites;
  String color;

  PokemonAttributesDTO.map(Map<String, dynamic> json, var jsonTypes) {
    this.id = json['id'];
    this.name = json['name'];
    this.baseExperience = json['base_experience'];
    this.height = json['height'];
    this.isDefault = json['is_default'];
    this.order = json['order'];
    this.weight = json['weight'];
    this.types = setTypes(jsonTypes);
    this.sprites = json['sprites']['front_default'];
    this.color = "";
  } //end map construtor

  List<PokemonTypeDTO> setTypes(var list) {
    List<PokemonTypeDTO> lista = [];
    final Map<String, dynamic> data = new Map<String, dynamic>();

    for (int i = 0; i < list.length; i++) {
      data['name'] = list[i]['name'].toString();
      data['url'] = list[i]['url'].toString();
      //print("ENTRADA " + data.toString());
      PokemonTypeDTO poke = PokemonTypeDTO.map(data);
      lista.add(poke);
      //print("SAIDA DE DADOS " + lista.toString());
    } //end for
    return lista;
  } //end setType

} //end class
