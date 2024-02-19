import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_app/data/PokemonDTO.dart';
import 'package:pokedex_app/util/colors_util.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homecontroller = HomeController();
  final _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: this._buildBody(),
    );
  } //end build

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Pokedex",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
          ),
        ),
      ],
    );
  } //end _appBar

  FocusNode focus = FocusNode();
  Widget _search() {
    return TextFormField(
      focusNode: focus,
      controller: this._txtController,
      //Content
      maxLines: 1,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      //Decoration
      decoration: InputDecoration(
        //Border icon and background color
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Container(
          padding: EdgeInsets.all(12),
          // child: Container(),
          child: SvgPicture.asset(
            "assets/images/search.svg",
            color: Colors.black,
          ),
        ),
        //Hint text and settings
        hintText: "Search here",
        hintStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.1),
        ),
        //CircularBorder
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none),
        //OpenedBorderSettings
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      onFieldSubmitted: (_) {},
    );
  } //end _search FocusScope.of(context).unfocus();

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 48),
          this._appBar(),
          SizedBox(height: 12),
          this._search(),
          SizedBox(height: 18),
          Observer(builder: (_) {
            return Expanded(
              child: homecontroller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        //espessura
                        strokeWidth: 2,
                        backgroundColor: Colors.white,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : GridView.count(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 2,
                      children: homecontroller.pokemons.isNotEmpty
                          ? this.homecontroller.pokemons.map((pokemonDTO) {
                              return this.pokeCard(pokemonDTO);
                            }).toList()
                          : Text("Pokemons não encontrados"),
                    ),
            );
          }),
        ],
      ),
    );
  } //end _buildBody

  Widget pokeCard(PokemonDTO pokemonDTO) {
    return Observer(builder: (_) {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: ColorsUtil.takeColor(pokemonDTO.attributes.color),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: EdgeInsets.fromLTRB(12, 24, 12, 24),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemonDTO.name ?? "null",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
                //Tipos
                _buildType(pokemonDTO.attributes.types[0].name,
                    pokemonDTO.attributes.color),
                SizedBox(height: 8),
                pokemonDTO.attributes.types.length == 2
                    ? _buildType(pokemonDTO.attributes.types[1].name,
                        pokemonDTO.attributes.color)
                    : Container(),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 0,
            child: Image.network(
              pokemonDTO.attributes.sprites,
            ),
          ),
        ],
      );
    });
  } //end pokeCard

  Widget _buildType(String name, cor) {
    return Container(
      //width: 23,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white.withOpacity(0.3),
      ),
      child: name.isNotEmpty && name != null
          ? Text(
              name,
              style: TextStyle(
                letterSpacing: 0.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            )
          : Text(
              "Não encontrado",
              style: TextStyle(
                letterSpacing: 0.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
    );
  } //end _buildType

} //end class
