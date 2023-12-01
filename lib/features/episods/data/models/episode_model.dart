class Episode {
  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });
  late final int id;
  late final String name;
  late final String airDate;
  late final String episode;
  late final List<String> characters;
  late final String url;
  late final String created;
  
  Episode.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    airDate = json['air_date'];
    episode = json['episode'];
    characters = List.castFrom<dynamic, String>(json['characters']);
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['air_date'] = airDate;
    _data['episode'] = episode;
    _data['characters'] = characters;
    _data['url'] = url;
    _data['created'] = created;
    return _data;
  }
}