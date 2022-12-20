import 'dart:convert';
import 'dart:developer';

import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  Future<DictionaryModel?> fetchApi(String value) async {
    try {
      Response response = await Dio()
          .get('https://api.urbandictionary.com/v0/define?term=$value');

      DictionaryModel? model =
          dictionaryModelFromJson(jsonEncode(response.data));
      return model;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
