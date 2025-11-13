class Country {
  final String name;
  final String code;
  final List<dynamic> topics;

  Country({required this.name, required this.code, required this.topics});

  static Country fromJson(json) => Country(
    name: json['name'],
    code: json['code'],
    topics: (json['topics'] as List),
  );
}
