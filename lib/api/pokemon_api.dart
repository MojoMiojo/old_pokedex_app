import 'package:flutter/cupertino.dart';
import 'package:pokedex_app/api/utils/base_api.dart';
import 'package:pokedex_app/api/utils/network_api.dart';

class PokemonApi extends BaseApi {
  Future<dynamic> getPokemons() {
    return this
        .request(HttpMethod.GET, "pokemon/?limit=20&offset=0")
        .then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  } //end getPokemons

  Future<dynamic> getPokemonsAttributes({@required String url}) {
    /* return this.request(HttpMethod.GET, endpoint).then((response) { */
    return this.customGet(url).then((response) {
      return response;
    }).catchError((onError) {
      throw (onError);
    });
  } //end getPokemonsAttributes

  Future<dynamic> getPokemonColor({@required String pokeId}) {
    /* return this.request(HttpMethod.GET, endpoint).then((response) { */
    return this
        .customGet("https://pokeapi.co/api/v2/pokemon-species/" + pokeId)
        .then((response) {
      return response;
    }).catchError((onError) {
      throw (onError);
    });
  } //end getPokemonsAttributes

} //end pokemonApi
