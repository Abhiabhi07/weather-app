class FeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory FeelsLike.fromMap(Map<String, dynamic> json) => FeelsLike(
    day: json["day"]?.toDouble(),
    night: json["night"]?.toDouble(),
    eve: json["eve"]?.toDouble(),
    morn: json["morn"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "day": day,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}