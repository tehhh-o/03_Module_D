class News {
  final String id;
  final String title;
  final String country;
  final String topic;
  final String datetime;
  final String display_time;
  final String article;

  News({
    required this.id,
    required this.title,
    required this.country,
    required this.topic,
    required this.datetime,
    required this.display_time,
    required this.article,
  });

  static News fromjson(json) => News(
    id: json['id'],
    title: json['title'],
    country: json['country'],
    topic: json['topic'],
    datetime: json['datetime'],
    display_time: json['display_time'],
    article: json['article'],
  );
}
