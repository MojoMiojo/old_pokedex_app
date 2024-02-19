class PokemonTypeDTO {
  String name;
  String url;

  PokemonTypeDTO.map(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  } //end map

} //end class
