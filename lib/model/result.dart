import 'package:marvel_characters/model/container.dart';
import 'package:meta/meta.dart';

class Result {
  final int code;
  final String status;
  final Container container;
  final String etag;
  final String copyright;
  final String attributionText;
  final String attributionHTML;

  Result({
    @required this.code,
    @required this.status,
    @required this.container,
    @required this.etag,
    @required this.copyright,
    @required this.attributionText,
    @required this.attributionHTML,
  })  : assert(code != null),
        assert(status != null),
        assert(container != null),
        assert(etag != null),
        assert(copyright != null),
        assert(attributionText != null),
        assert(attributionHTML != null);

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      code: json['code'],
      status: json['status'],
      container: Container.fromJson(json['data']),
      etag: json['etag'],
      copyright: json['copyright'],
      attributionText: json['attributionText'],
      attributionHTML: json['attributionHTML'],
    );
  }
}
