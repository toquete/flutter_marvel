import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:marvel_characters/model/character.dart';

const _marvelKey = '8f856183ec2966942d063a0a4b1401b0';
const _marvelPrivateKey = 'd6d7e23b91bbecd81fc237c078b8177b476b4f91';

class Api {
  final String _url = 'gateway.marvel.com';

  Future<List<Character>> getCharacters(String name) async {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    var key = ts + _marvelPrivateKey + _marvelKey;
    final hash =
        hex.encode(crypto.md5.convert(Utf8Encoder().convert(key)).bytes);
    final params = {
      'ts': ts,
      'hash': hash,
      'apikey': _marvelKey,
      'nameStartsWith': name,
    };

    final uri = Uri.https(_url, '/v1/public/characters', params);
    final response = await http.Client().get(uri);
    final parsed = json.decode(response.body);

    return (parsed['data']['results'] as List)
        .map((data) => Character.fromJson(data))
        .toList();
  }
}
