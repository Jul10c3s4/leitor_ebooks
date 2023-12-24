import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText {
  static Widget buildMainTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  static Widget buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  static Widget buildTitleButton(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  static Widget buildSubTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildSubTitlePhoto(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
    );
  }

  static Widget buildTitleAutoSize(String title) {
    return AutoSizeText(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      minFontSize: 12,
    );
  }

  static Widget buildSubTitleAutoSize(String title) {
    return AutoSizeText(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      minFontSize: 12,
    );
  }

  static Widget buildSubTitleCard(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  static Widget builddataTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildCancelTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, color: Colors.red, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildOkTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
    );
  }
}
