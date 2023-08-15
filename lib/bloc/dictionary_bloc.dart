import 'package:bloc/bloc.dart';
import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:equatable/equatable.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  DictionaryBloc() : super(DictionaryInitial()) {
    on<DictionaryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
