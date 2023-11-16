import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/hour_temp_tile.dart';

import '../provider/location_provider.dart';

class FullReportPage extends StatelessWidget {
  FullReportPage({super.key, this.lat, this.lon});

  final lat;
  final lon;

  WeatherProvider weatherProvider = WeatherProvider();

  String getDate({int? timeStamp, String? pattern}) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp! * 1000);
    String x = DateFormat(pattern).format(time);
    return x;
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String today = DateFormat('yMMMMd').format(date);
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        title: const Text('Forecast Report'),
      ),
      body: FutureBuilder(
          future: weatherProvider.getDailyWeather(lat, lon),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today',
                          style: textStyle,
                        ),
                        Text(
                          today,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  HourTempTile(
                    lat: lat,
                    lon: lon,
                  ),
                  const SizedBox(
                    height: 10.00,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Next Forecast',
                      style: textStyle,
                    ),
                  ),
                  if (snapshot.hasData)
                    ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        getDate(
                                            timeStamp: data.dt,
                                            pattern: 'EEEE'),
                                        style:
                                            textStyle!.copyWith(fontSize: 17)),
                                    Text(
                                        getDate(
                                            timeStamp: data.dt,
                                            pattern: 'MMM,d'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ],
                                ),
                              ),
                              Text('${data.temp.max.toStringAsFixed(0)}°C',
                                  style: textStyle.copyWith(fontSize: 26)),
                              Image.asset(
                                'assets/weather/${data.weather![0].icon!.name}.png',
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  else if (snapshot.hasError)
                    Center(
                        child: Text(
                      snapshot.error.toString(),
                      style: textStyle,
                    ))
                  else
                    const Center(child: CircularProgressIndicator())
                ],
              ),
            );
          }),
    );
  }
}
