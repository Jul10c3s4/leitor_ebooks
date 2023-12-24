import 'package:hive/hive.dart';
part 'favorito.g.dart';

@HiveType(typeId: 1)
class Favorito extends HiveObject {
  @HiveField(0)
  String id = "";

  Favorito();

  Favorito.create(this.id);
}
