import 'package:mobx/mobx.dart';
import 'package:pokedex_app/api/pokemon_api.dart';
import 'package:pokedex_app/data/PokemonAttributesDTO.dart';
import 'package:pokedex_app/data/PokemonDTO.dart';
part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final _pokemonApi = PokemonApi();

  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) {
    this.isLoading = value;
    print("isLoading -> " + this.isLoading.toString());
  } //end setLoading

  @action
  _HomeController() {
    this.buscarPokemons();
  } //end construtor

  @observable
  ObservableList<PokemonDTO> _pokemonsList = ObservableList<PokemonDTO>.of([]);

  @computed
  List<PokemonDTO> get pokemons {
    return this._pokemonsList;
  } //end get pokemons

  @action //Retorna o nome e url dos Pokemons
  buscarPokemons() {
    setLoading(true);
    _pokemonApi.getPokemons().then((response) {
      print('SUCESSO');
      if (response != null && response['results'] != null) {
        var list = response['results'] as List;
        if (this._pokemonsList.isNotEmpty) {
          List<PokemonDTO> morePokemons =
              list.map((i) => PokemonDTO.map(i)).toList();
          for (var i = 0; i < morePokemons.length; i++) {
            this._pokemonsList.add(morePokemons[i]);
          } //end for lista infinita
        }
        //Lista vazia, adicionar todos
        else {
          this
              ._pokemonsList
              .addAll(list.map((i) => PokemonDTO.map(i)).toList());
          //Adicionar atributos
          for (var i = 0; i < _pokemonsList.length; i++) {
            buscarAtributos(i, _pokemonsList[i].url);
          } //end for
        } //end else adicionar todos
      }
    }).catchError((error) {
      print('ERRO -> $error');
      setLoading(false);
    });
  } //end buscarPokemons

  @action //Retorna atributos dos pokemons
  void buscarAtributos(int index, String url) {
    _pokemonApi.getPokemonsAttributes(url: url).then((response) {
      print('SUCESSO');
      if (response != null) {
        var listTypes = response['types'];
        var type = [];
        for (var i = 0; i < listTypes.length; i++) {
          type.add(listTypes[i]['type']);
        }
        //print("TYPE -> " + type.toString());
        _pokemonsList[index].attributes =
            PokemonAttributesDTO.map(response, type);
        buscarCor(index);
      }
    }).catchError((error) {
      print('ERRO -> $error');
      setLoading(false);
    });
  } //end buscarAtributos

  @action
  buscarCor(int index) {
    _pokemonApi
        .getPokemonColor(pokeId: _pokemonsList[index].attributes.id.toString())
        .then((response) {
      print("SUCESSO");
      if (response != null && response["color"]["name"] != "") {
        _pokemonsList[index].attributes.color = response["color"]["name"];
        print("Cor " + _pokemonsList[index].attributes.color);
      }
      setLoading(false);
    }).catchError((error) {
      print('ERRO -> $error');
    });
  } //buscarCor

} //end class HomeController
