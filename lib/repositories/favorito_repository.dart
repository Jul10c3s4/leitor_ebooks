import 'package:hive/hive.dart';
import 'package:leitor_ebooks/models/favorito.dart';

class FavoritoRepository {
  static late Box _box;
  static const String CHAVE_FAVORITO = "CHAVE_FAVORITO";

  FavoritoRepository._create();

  static Future<FavoritoRepository> load() async {
    if (Hive.isBoxOpen(CHAVE_FAVORITO)) {
      _box = Hive.box(CHAVE_FAVORITO);
    } else {
      _box = await Hive.openBox(CHAVE_FAVORITO);
    }

    return FavoritoRepository._create();
  }

  void favoritar(String id) {
    print("favoritar");
    Favorito favorito = Favorito.create(id);
    _box.add(favorito);
  }

  void desfavoritar(Favorito favorito) {
    print("desfavoritar");
    favorito.delete();
  }

  List<Favorito> getFavoritos() {
    return _box.values.cast<Favorito>().toList();
  }
}
