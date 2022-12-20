import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:dictionary_api/services/api_service.dart';
import 'package:flutter/material.dart';

class ApiProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  DictionaryModel? dictValue;

  Future<void> getValues(String value) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.fetchApi(value);
    dictValue = response;
    isLoading = false;
    notifyListeners();
  }
}
