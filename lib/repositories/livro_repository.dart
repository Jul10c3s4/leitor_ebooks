import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks/models/livro.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class LivrosRepository {
  LivrosRepository();
  Future<List<Livro>> getLivros() async {
    List<Livro> livros = <Livro>[];

    var result = await http.get(Uri.parse('https://escribo.com/books.json'));

    if (result.statusCode == 200) {
      for (var livro in jsonDecode(result.body)) {
        livros.add(Livro.fromJson(livro));
      }
    }
    return livros;
  }

  Future<dynamic> dowloadFromApi(String downloadUrl, String fileName) async {
    String filePath = "";
    final result = await http.get(Uri.parse(downloadUrl));

    if (result.statusCode == 200) {
      final String path = (await getApplicationDocumentsDirectory()).path;
      final File file = File('$path/$fileName');

      await file.writeAsBytes(result.bodyBytes);
      print('Arquivo baixado e salvo em: ${file.path}');
    } else {
      print('Erro na requisição: ${result.statusCode}');
    }
  }
}
