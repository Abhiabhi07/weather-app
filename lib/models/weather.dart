import 'description.dart';
import 'icon.dart';
import 'main_condition.dart';

class Weather {
  final int id;
  final Main? main;
  final Description? description;
  final Icon? icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromMap( Map<String, dynamic>  json) => Weather(
    id: json["id"],
    main: mainValues.map[json["main"]],
    description: descriptionValues.map[json["description"]],
    icon: iconValues.map[json["icon"]],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "main": mainValues.reverse[main],
    "description": descriptionValues.reverse[description],
    "icon": iconValues.reverse[icon],
  };
}
