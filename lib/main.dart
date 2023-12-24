import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leitor_ebooks/leitor_ebook_app.dart';
import 'package:leitor_ebooks/models/favorito.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(FavoritoAdapter());
  runApp(const LeitorEbookApp());
}
