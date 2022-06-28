class DictionaryModel {
  List<ListData>? list;

  DictionaryModel({this.list});

  DictionaryModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ListData>[];
      json['list'].forEach((v) {
        list!.add(ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  String? definition;
  String? permalink;
  int? thumbsUp;
  List<String>? soundUrls;
  String? author;
  String? word;
  int? defid;
  String? currentVote;
  String? writtenOn;
  String? example;
  int? thumbsDown;

  ListData(
      {this.definition,
      this.permalink,
      this.thumbsUp,
      this.soundUrls,
      this.author,
      this.word,
      this.defid,
      this.currentVote,
      this.writtenOn,
      this.example,
      this.thumbsDown});

  ListData.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    permalink = json['permalink'];
    thumbsUp = json['thumbs_up'];
    soundUrls = json['sound_urls'].cast<String>();
    author = json['author'];
    word = json['word'];
    defid = json['defid'];
    currentVote = json['current_vote'];
    writtenOn = json['written_on'];
    example = json['example'];
    thumbsDown = json['thumbs_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['permalink'] = permalink;
    data['thumbs_up'] = thumbsUp;
    data['sound_urls'] = soundUrls;
    data['author'] = author;
    data['word'] = word;
    data['defid'] = defid;
    data['current_vote'] = currentVote;
    data['written_on'] = writtenOn;
    data['example'] = example;
    data['thumbs_down'] = thumbsDown;
    return data;
  }
}
