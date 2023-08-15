part of 'dictionary_bloc.dart';

sealed class DictionaryEvent extends Equatable {
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class SearchWord extends DictionaryEvent {
  final String searchKey;
  const SearchWord(this.searchKey);
}

class ClearSearch extends DictionaryEvent {}
