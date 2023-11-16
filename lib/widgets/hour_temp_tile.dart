import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/btm_sheet.dart';

import '../models/hour.dart';
import '../provider/location_provider.dart';
import 'custom_chip.dart';

class HourTempTile extends StatelessWidget {
  HourTempTile({super.key, this.lat, this.lon,});

  final lat;
  final lon;

 final WeatherProvider weatherProvider = WeatherProvider();

  String getTime(timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('h:mm a').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: weatherProvider.getHourlyWeather(lat, lon),
        builder: (context, AsyncSnapshot<List<Hour>?> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return SizedBox(
              height: 180,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: data!.length > 8 ? 8 : data.length,
                  itemBuilder: (ctx, index) {
                    final hour = data[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          backgroundColor: const Color(0xff08082d),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0)),
                          ),
                          context: context,
                          builder: (context) => BtmSheet(
                            hour: hour,
                            time: getTime(hour.dt),
                          ),
                        );
                      },
                      child: Container(
                          width: 90,
                          margin: const EdgeInsets.all(14.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(20.0),
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${hour.temp.toStringAsFixed(0)}°C',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Image.asset(
                                'assets/weather/${hour.weather[0].icon?.name}.png',
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                getTime(hour.dt),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
