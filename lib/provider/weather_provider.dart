import 'dart:convert';
import '../models/current.dart';
import 'package:http/http.dart' as http;

import '../models/daily.dart';
import '../models/hour.dart';

const api_key = 'bd86d5c6c26128bac91fcfa338df71ef';
// const api_key = '2cb9dd514a8ae00b9a6397d3f7ae536a';

class WeatherProvider {
  Future<Current> getCurrentWeather(lat, lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$api_key&units=metric');

    final response = await http.get(url);

    final responseBody = json.decode(response.body);
    final currentWeather = Current.fromMap(responseBody['current']);
    return currentWeather;
  }

  Future<List<Hour>?> getHourlyWeather(lat, lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$api_key&units=metric');

    final response = await http.get(url);
    final responseBody = jsonDecode(response.body);

    final data = await responseBody['hourly'] as List<dynamic>;
    final printData =
        data.map((e) => Hour.fromMap(e as Map<String, dynamic>)).toList();
    return printData;
  }

  Future<List<Daily>> getDailyWeather(lat, lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$api_key&units=metric');
    final response = await http.get(url);
    final responseBody = json.decode(response.body);
    final body = responseBody['daily'] as List<dynamic>;
    return body.map((e) => Daily.fromMap(e)).toList();
  }
}
