import 'dart:convert';

import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DictionaryModel? model;

  Future<DictionaryModel?> fetchApi(String value) async {
    Response response = await get(
        Uri.parse('https://api.urbandictionary.com/v0/define?term=$value'));

    try {
      debugPrint(response.body);
      return model = DictionaryModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }

  void autoCompleteSearch(String value) async {
    var result = await fetchApi(value);
    setState(() {
      model = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary API'),
      ),
      body: Center(
        child: Column(
          children: [
            _searchBar(context),
          ],
        ),
      ),
    );
  }

  Container _searchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: ((value) {
          if (value.isNotEmpty) {
            autoCompleteSearch(value);
          } else {
            model = null;
          }
        }),
      ),
    );
  }
}
