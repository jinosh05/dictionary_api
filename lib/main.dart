import "dart:convert";
import "dart:developer";

import "package:dictionary_api/models/dictionary_model.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";

void main() {
  runApp(const MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DictionaryModel? model;
  final TextEditingController controller = TextEditingController();

  Future<DictionaryModel?> fetchApi(String value) async {
    final Response response = await get(
      Uri.parse("https://api.urbandictionary.com/v0/define?term=$value"),
    );

    try {
      debugPrint(response.body);
      return model = DictionaryModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> autoCompleteSearch(String value) async {
    final DictionaryModel? result = await fetchApi(value);
    setState(() {
      model = result;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Dictionary API"),
        ),
        body: Column(
          children: <Widget>[
            _searchBar(context),
            _resultContents(),
          ],
        ),
      );

  Expanded _resultContents() => Expanded(
        child: ListView.separated(
          itemCount: model == null ? 0 : model!.list!.length,
          itemBuilder: (BuildContext context, int index) => _DictionaryItem(
            index: index,
            data: model!.list![index],
          ),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 10,
          ),
        ),
      );

  Container _searchBar(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () async {
                controller.clear();
                await autoCompleteSearch(" ");
              },
              icon: const Icon(
                Icons.clear,
                size: 25,
              ),
            ),
          ),
          onChanged: (String value) async {
            if (value.isNotEmpty) {
              await autoCompleteSearch(controller.text);
            } else {
              model = null;
            }
          },
        ),
      );
}

class _DictionaryItem extends StatelessWidget {
  const _DictionaryItem({required this.index, required this.data});
  final int index;
  final ListData data;

  @override
  Widget build(BuildContext context) => Container(
        color: index.isEven ? Colors.black12 : Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.20,
              child: Text(
                data.word ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: Text(
                data.definition ?? "",
              ),
            ),
          ],
        ),
      );
}
