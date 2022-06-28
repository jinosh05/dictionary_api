import 'dart:convert';

import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dictionary API'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                onChanged: ((value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    model = null;
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
