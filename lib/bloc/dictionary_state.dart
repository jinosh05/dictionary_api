part of 'dictionary_bloc.dart';

sealed class DictionaryState extends Equatable {
  const DictionaryState();

  @override
  List<Object> get props => [];
}

final class DictionaryInitial extends DictionaryState {}

final class DictionaryLoaded extends DictionaryState {
  final DictionaryModel dictValue;
  const DictionaryLoaded(this.dictValue);
}

final class DictionaryLoading extends DictionaryState {}

final class DictionaryEmpty extends DictionaryState {}
