class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temp.fromMap(Map<String, dynamic> json) => Temp(
    day: json["day"]?.toDouble(),
    min: json["min"]?.toDouble(),
    max: json["max"]?.toDouble(),
    night: json["night"]?.toDouble(),
    eve: json["eve"]?.toDouble(),
    morn: json["morn"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "day": day,
    "min": min,
    "max": max,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}