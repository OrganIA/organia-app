import 'package:organia/src/data/organia_api_provider.dart';
import 'package:organia/src/models/user.dart';
// import 'package:organia/models/pokemon.dart';
// import 'package:organia/models/pokemon_list.dart';

class OrganIAAPIRepository {
  final OrganIAAPIProvider _organIAAPIProvider = OrganIAAPIProvider();

  Future<User> login() => _organIAAPIProvider.login();
  // Future<PokemonList> fetch20MorePokemons(PokemonList list) =>
  //     _OrganIAAPIProvider.fetch20MorePokemons(list);
}
