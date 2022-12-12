// To parse this JSON data, do
//
//     final dictionaryModel = dictionaryModelFromJson(jsonString);

import 'dart:convert';

DictionaryModel dictionaryModelFromJson(String str) =>
    DictionaryModel.fromJson(json.decode(str));

String dictionaryModelToJson(DictionaryModel data) =>
    json.encode(data.toJson());

class DictionaryModel {
  DictionaryModel({
    required this.list,
  });

  List<ListElement> list;

  factory DictionaryModel.fromJson(Map<String, dynamic> json) =>
      DictionaryModel(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.definition,
    required this.permalink,
    required this.thumbsUp,
    required this.author,
    required this.word,
    required this.defid,
    required this.currentVote,
    required this.writtenOn,
    required this.example,
    required this.thumbsDown,
  });

  String definition;
  String permalink;
  int thumbsUp;
  String author;
  String word;
  int defid;
  String currentVote;
  DateTime writtenOn;
  String example;
  int thumbsDown;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        definition: json["definition"],
        permalink: json["permalink"],
        thumbsUp: json["thumbs_up"],
        author: json["author"],
        word: json["word"],
        defid: json["defid"],
        currentVote: json["current_vote"],
        writtenOn: DateTime.parse(json["written_on"]),
        example: json["example"],
        thumbsDown: json["thumbs_down"],
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "permalink": permalink,
        "thumbs_up": thumbsUp,
        "author": author,
        "word": word,
        "defid": defid,
        "current_vote": currentVote,
        "written_on": writtenOn.toIso8601String(),
        "example": example,
        "thumbs_down": thumbsDown,
      };
}
