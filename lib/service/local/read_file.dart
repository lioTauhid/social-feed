import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ReadFile {
  Future<dynamic> readAssetsJson(context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/jsoncrack.json");
    final jsonResult = jsonDecode(data); //latest Dart
    return jsonResult;
  }
}
