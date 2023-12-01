class ResponseWrapper {
  ResponseWrapper({
    required this.info,
    required this.results,
  });
  late final Info info;
  late final List<dynamic> results;

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    info = Info.fromJson(json['info']);
    results = List.castFrom<dynamic, dynamic>(json['results']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['info'] = info.toJson();
    _data['results'] = results;
    return _data;
  }
}

class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });
  late final int count;
  late final int pages;
  late final String? next;
  late final String? prev;

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['pages'] = pages;
    _data['next'] = next;
    _data['prev'] = prev;
    return _data;
  }
}
