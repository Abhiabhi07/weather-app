import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/hour.dart';

import 'custom_chip.dart';

class BtmSheet extends StatelessWidget {
  const BtmSheet({super.key, required this.hour, required this.time});

  final Hour hour;
  final String time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hourly',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/weather/${hour.weather[0].icon?.name}.png',
                    width: 90,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    '${hour.temp.toStringAsFixed(0)}°C',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  Column(
                    children: [
                      Text(
                        '${hour.weather[0].main?.name}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomChip(
                    icon: CupertinoIcons.cloud_sun,
                    title: '${hour.pressure}',
                    subtitle: 'Pressure',
                  ),
                  CustomChip(
                    icon: CupertinoIcons.drop,
                    title: '${hour.humidity}%',
                    subtitle: 'Humidity',
                  ),
                  CustomChip(
                    icon: CupertinoIcons.wind_snow,
                    title: '${hour.windSpeed}km/h',
                    subtitle: 'Wind speed',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
