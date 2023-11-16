class Rain {
  final double oneHour;

  Rain({
    required this.oneHour,
  });

  factory Rain.fromMap(Map<String, dynamic> json) => Rain(
    oneHour: json["1h"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "1h": oneHour,
  };
}