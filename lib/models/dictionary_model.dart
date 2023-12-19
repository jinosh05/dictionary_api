class DictionaryModel {
  DictionaryModel({this.list});

  DictionaryModel.fromJson(Map<String, dynamic> json) {
    list = <ListData>[];
    if (json["list"] != null) {
      for (final dynamic v in json["list"] as List<dynamic>) {
        list!.add(ListData.fromJson(v));
      }
    }
  }
  List<ListData>? list;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data["list"] = list!.map((ListData v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  ListData({
    this.definition,
    this.permalink,
    this.thumbsUp,
    this.author,
    this.word,
    this.defid,
    this.currentVote,
    this.writtenOn,
    this.example,
    this.thumbsDown,
  });

  ListData.fromJson(Map<String, dynamic> json) {
    definition = json["definition"];
    permalink = json["permalink"];
    thumbsUp = json["thumbs_up"];
    author = json["author"];
    word = json["word"];
    defid = json["defid"];
    currentVote = json["current_vote"];
    writtenOn = json["written_on"];
    example = json["example"];
    thumbsDown = json["thumbs_down"];
  }
  String? definition;
  String? permalink;
  int? thumbsUp;
  String? author;
  String? word;
  int? defid;
  String? currentVote;
  String? writtenOn;
  String? example;
  int? thumbsDown;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["definition"] = definition;
    data["permalink"] = permalink;
    data["thumbs_up"] = thumbsUp;
    data["author"] = author;
    data["word"] = word;
    data["defid"] = defid;
    data["current_vote"] = currentVote;
    data["written_on"] = writtenOn;
    data["example"] = example;
    data["thumbs_down"] = thumbsDown;
    return data;
  }
}
