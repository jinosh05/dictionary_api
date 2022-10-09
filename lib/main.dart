import 'dart:convert';

import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DictionaryModel? model;
  final TextEditingController controller = TextEditingController();

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
      body: Column(
        children: [
          _searchBar(context),
          _resultContents(),
        ],
      ),
    );
  }

  Expanded _resultContents() {
    return Expanded(
      child: ListView.separated(
        itemCount: model == null ? 0 : model!.list!.length,
        itemBuilder: (BuildContext context, int index) {
          List<ListData> ld = model!.list!;
          return Container(
            color: index.isEven ? Colors.black12 : Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
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
                  ),
                )
              ],
            ),
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
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                  autoCompleteSearch(" ");
                },
                icon: const Icon(
                  Icons.clear,
                  size: 25,
                ))),
        onChanged: ((value) {
          if (value.isNotEmpty) {
            autoCompleteSearch(controller.text);
          } else {
            model = null;
          }
        }),
      ),
    );
  }
}
