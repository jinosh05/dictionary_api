import 'dart:convert';
import 'dart:developer';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _searchBar(context),
            _resultContents(),
          ],
        ),
      ),
    );
  }

  Expanded _resultContents() {
    return Expanded(
      child: ListView.separated(
        itemCount: model == null ? 0 : model!.list!.length,
        itemBuilder: (BuildContext context, int index) {
          log(model!.list!.length.toString());
          List<ListData> ld = model!.list!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text(
                    ld[index].word ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Text(
                  ld[index].definition ?? "",
                  style: TextStyle(
                    color: index % 2 == 0 ? Colors.purple : Colors.blue,
                  ),
                ),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
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
