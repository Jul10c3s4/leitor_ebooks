import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leitor_ebooks/models/favorito.dart';
import 'package:leitor_ebooks/repositories/favorito_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:leitor_ebooks/models/livro.dart';
import 'package:leitor_ebooks/repositories/livro_repository.dart';
import 'package:leitor_ebooks/shared/Custom_buttom.dart';
import 'package:leitor_ebooks/shared/book_card.dart';
import 'package:leitor_ebooks/shared/custom_appbar.dart';
import 'package:leitor_ebooks/shared/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FavoritoRepository favoritoRepository;
  List<Favorito> listaFavoritos = [];
  List<Livro> livros = <Livro>[];
  List<Livro> livrosExibidos = <Livro>[];
  LivrosRepository livrosRepository = LivrosRepository();
  final platform = const MethodChannel('my_channel');
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";
  bool favoritos = false;

  @override
  void initState() {
    // TODO: implement initState
    loading = true;
    setState(() {});
    getLivros();
    //download();
    super.initState();
  }

  getLivros() async {
    livros = await livrosRepository.getLivros();
    favoritoRepository = await FavoritoRepository.load();
    listaFavoritos = favoritoRepository.getFavoritos();
    if (listaFavoritos.isNotEmpty) {
      for (var livro in livros) {
        for (var favorito in listaFavoritos) {
          if (livro.id == favorito.id) {
            livro.favorito = true;
          }
        }
      }
    }
    if (favoritos) {
      setState(() {});
      getLivrosFavoritos();
    } else {
      livrosExibidos = livros;
    }
    loading = false;
    setState(() {});
  }

  getLivrosFavoritos() async {
    loading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    favoritos = true;
    livrosExibidos = livros.where((livro) => livro.favorito == true).toList();
    loading = false;
    setState(() {});
  }

  download(String urlDowload, String id) async {
    if (Platform.isAndroid || Platform.isIOS) {
      String? firstPart;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      if (allInfo['version']["release"].toString().contains(".")) {
        int indexOfFirstDot = allInfo['version']["release"].indexOf(".");
        firstPart = allInfo['version']["release"].substring(0, indexOfFirstDot);
      } else {
        firstPart = allInfo['version']["release"];
      }
      int intValue = int.parse(firstPart!);
      if (intValue >= 13) {
        await startDownload(urlDowload, id);
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          await startDownload(urlDowload, id);
        } else {
          await startDownload(urlDowload, id);
        }
      }
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(title: "Leitor de E-books"),
            body: loading
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          CustomButtom(
                              title: CustomText.buildTitleButton("Livros"),
                              color: const Color(0xFFF25C05),
                              onPressed: () {
                                loading = true;
                                setState(() {});
                                favoritos = false;
                                getLivros();
                              }),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomButtom(
                              title: CustomText.buildTitleButton("Favoritos"),
                              color: const Color(0xFFF25C05),
                              onPressed: getLivrosFavoritos),
                        ],
                      ),
                      livrosExibidos.isEmpty
                          ? Expanded(
                              child: Center(
                                child: CustomText.buildTitle(
                                    "Não há nenhum livro favoritado!"),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  itemCount: livrosExibidos.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 365,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    Livro livro = livrosExibidos[index];
                                    return BookCard(
                                      livro: livro,
                                      clickImage: (() => download(
                                          livro.downloadUrl!,
                                          livro.id.toString())),
                                      favoritar: (() => {
                                            favoritoRepository
                                                .favoritar(livro.id!),
                                            getLivros()
                                          }),
                                      desfavoritar: (() => {
                                            favoritoRepository.desfavoritar(
                                                listaFavoritos.singleWhere(
                                                    (favorito) =>
                                                        favorito.id ==
                                                        livro.id)),
                                            getLivros()
                                          }),
                                    );
                                  }),
                            )
                    ],
                  )));
  }

  startDownload(String urlDowload, String id) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/$id.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        urlDowload,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
          print(filePath);
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
    VocsyEpub.setConfig(
      themeColor: const Color(0xFF592202),
      identifier: "AndroidBook",
      scrollDirection: EpubScrollDirection.VERTICAL,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    // get current locator
    VocsyEpub.locatorStream.listen((locator) {
      print('LOCATOR: $locator');
    });

    VocsyEpub.open(
      filePath,
    );
    filePath = "";
  }
}
