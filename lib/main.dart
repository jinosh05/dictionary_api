import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dictionary_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DictionaryBloc(),
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DictionaryBloc bloc = BlocProvider.of(context);
    bloc.add(const SearchWord(" "));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary API'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: width * 0.5),
            child: Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: BlocBuilder<DictionaryBloc, DictionaryState>(
                    builder: (context, state) {
                      return state is DictionaryLoading
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(),
                            )
                          : IconButton(
                              onPressed: () {
                                controller.clear();
                                bloc.add(const SearchWord(" "));
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 25,
                              ),
                            );
                    },
                  ),
                ),
                onChanged: ((text) {
                  bloc.add(SearchWord(text));
                }),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<DictionaryBloc, DictionaryState>(
              builder: (context, state) {
                if (state is DictionaryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DictionaryLoaded) {
                  return ListView.separated(
                    itemCount: state.dictValue.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<ListElement> ld = state.dictValue.list;
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
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
