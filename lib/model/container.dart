import 'package:marvel_characters/model/character.dart';
import 'package:meta/meta.dart';

class Container {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> characters;

  Container({
    @required this.offset,
    @required this.limit,
    @required this.total,
    @required this.count,
    @required this.characters,
  })  : assert(offset != null),
        assert(limit != null),
        assert(total != null),
        assert(count != null),
        assert(characters != null);

  factory Container.fromJson(Map<String, dynamic> json) {
    return Container(
        offset: json['id'],
        limit: json['limit'],
        total: json['total'],
        count: json['count'],
        characters: (json['results'] as List).map((i) => Character.fromJson(i)).toList(),
    );
  }

}
