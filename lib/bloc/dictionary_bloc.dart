import 'package:bloc/bloc.dart';
import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:dictionary_api/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final _service = ApiService();
  final TextEditingController searchCtrl = TextEditingController();

  DictionaryBloc() : super(DictionaryInitial()) {
    on<DictionaryEvent>((event, emit) async {
      if (event is SearchWord) {
        emit(DictionaryLoading());
        // final response = await _fetchAPi(event);
        var list = await Future.value([
          await _fetchAPi(event),
          await _getText(),
          await _getNumber(),
        ]);
        var dictData = list[0] as DictionaryModel?;

        if (dictData != null) {
          emit(DictionaryLoaded(dictData));
        } else {
          emit(DictionaryEmpty());
        }
      } else if (event is ClearSearch) {
        searchCtrl.clear();
        emit(DictionaryEmpty());
      }
    });
  }

  Future<DictionaryModel?> _fetchAPi(SearchWord event) =>
      _service.fetchApi(event.searchKey);

  Future<String> _getText() async {
    await Future.delayed(const Duration(seconds: 2));
    return "working";
  }

  Future<int> _getNumber() async {
    await Future.delayed(const Duration(seconds: 2));
    return 3;
  }
}
