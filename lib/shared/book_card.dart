import 'package:flutter/material.dart';
import 'package:leitor_ebooks/models/favorito.dart';
import 'package:leitor_ebooks/models/livro.dart';
import 'package:leitor_ebooks/shared/custom_text.dart';

class BookCard extends StatefulWidget {
  final Livro livro;
  final Future<dynamic> Function() clickImage;
  final void Function() favoritar;
  final void Function() desfavoritar;
  const BookCard(
      {super.key,
      required this.livro,
      required this.clickImage,
      required this.favoritar,
      required this.desfavoritar});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: InkWell(
                    onTap: (() => widget.clickImage()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${widget.livro.coverUrl}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: widget.livro.favorito
                          ? (() => widget.desfavoritar())
                          : (() => widget.favoritar()),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12)),
                        child: Image.asset(
                          widget.livro.favorito
                              ? "assets/icon/remove.png"
                              : "assets/icon/favorito.png",
                          width: 42,
                          height: 67,
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Flexible(
                flex: 7,
                child: CustomText.buildTitleAutoSize(
                    widget.livro.titulo.toString())),
            Flexible(
                flex: 3,
                child: CustomText.buildSubTitleAutoSize(
                    widget.livro.autor.toString())),
          ],
        ),
      ),
    );
  }
}
