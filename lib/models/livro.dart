import 'dart:ffi';

class Livro {
  String? id;
  String? titulo;
  String? autor;
  String? coverUrl;
  String? downloadUrl;
  bool _favorito = false;

  Livro({this.id, this.titulo, this.autor, this.coverUrl, this.downloadUrl});

  bool get favorito => _favorito;
  set favorito(bool favorito) => _favorito = favorito;
  Livro.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    titulo = json['title'];
    autor = json['author'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['título'] = titulo;
    data['autor'] = autor;
    data['cover_url'] = coverUrl;
    data['download_url'] = downloadUrl;
    return data;
  }
}
