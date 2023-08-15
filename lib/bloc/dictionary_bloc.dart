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
        final response = await _service.fetchApi(event.searchKey);
        if (response != null) {
          emit(DictionaryLoaded(response));
        } else {
          emit(DictionaryEmpty());
        }
      }
    });
  }
}
