// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  Computed<List<PokemonDTO>> _$pokemonsComputed;

  @override
  List<PokemonDTO> get pokemons =>
      (_$pokemonsComputed ??= Computed<List<PokemonDTO>>(() => super.pokemons,
              name: '_HomeController.pokemons'))
          .value;

  final _$isLoadingAtom = Atom(name: '_HomeController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_pokemonsListAtom = Atom(name: '_HomeController._pokemonsList');

  @override
  ObservableList<PokemonDTO> get _pokemonsList {
    _$_pokemonsListAtom.reportRead();
    return super._pokemonsList;
  }

  @override
  set _pokemonsList(ObservableList<PokemonDTO> value) {
    _$_pokemonsListAtom.reportWrite(value, super._pokemonsList, () {
      super._pokemonsList = value;
    });
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscarPokemons() {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.buscarPokemons');
    try {
      return super.buscarPokemons();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarAtributos(int index, String url) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.buscarAtributos');
    try {
      return super.buscarAtributos(index, url);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscarCor(int index) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.buscarCor');
    try {
      return super.buscarCor(index);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pokemons: ${pokemons}
    ''';
  }
}
