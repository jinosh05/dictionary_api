import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:dictionary_api/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getValues('');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary API'),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, ApiProvider value, child) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: width * 0.9,
                child: Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: value.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(),
                              )
                            : IconButton(
                                onPressed: () {
                                  controller.clear();
                                  value.getValues(' ');
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  size: 25,
                                ))),
                    onChanged: ((text) {
                      value.getValues(controller.text);
                    }),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: value.dictValue == null
                      ? 0
                      : value.dictValue!.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<ListElement> ld = value.dictValue!.list;
                    return Container(
                      color: index.isEven ? Colors.black12 : Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                ld[index].word,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: Text(
                              ld[index].definition,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
