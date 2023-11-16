import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/pages/full_report_page.dart';
import 'package:weather_app/provider/location_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/custom_chip.dart';
import 'package:weather_app/widgets/hour_temp_tile.dart';

LocationProvider locationProvider = LocationProvider();

dynamic latitude = locationProvider.getLatitude();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherProvider weatherProvider = WeatherProvider();
  String cityName = 'City Name';

  getCityName(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      cityName = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var values = Provider.of<LocationProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.add),
          title: Text(cityName),
          actions: [
            IconButton(
                onPressed: () {
                  getCityName(values.getLatitude(), values.getLongitude());
                },
                icon: const Icon(Icons.refresh))
          ],
        ),


        body: FutureBuilder(
            future: Provider.of<LocationProvider>(context).getLocation(context),
            builder: (context, AsyncSnapshot<Current?> snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Image.asset(
                            'assets/weather/${snapshot.data!.weather[0].icon?.name}.png',
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        '${data!.temp.toStringAsFixed(0)}°C',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${data.weather[0].main?.name}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat('h:mm a').format(DateTime.now()),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomChip(
                              icon: CupertinoIcons.cloud_sun,
                              title: '${snapshot.data!.pressure}',
                              subtitle: 'Pressure',
                            ),
                            CustomChip(
                              icon: CupertinoIcons.drop,
                              title: '${data.humidity}%',
                              subtitle: 'Humidity',
                            ),
                            CustomChip(
                              icon: CupertinoIcons.wind_snow,
                              title: '${data.windSpeed}km/h',
                              subtitle: 'Wind speed',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                              child: Text(
                                'View full report',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.deepPurpleAccent),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => FullReportPage(
                                          lat: values.getLatitude(),
                                          lon: values.getLongitude(),
                                        )));
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      HourTempTile(
                        lat: values.getLatitude(),
                        lon: values.getLongitude(),
                      ),
                    ]);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('ja').format(time);
    return x;
  }
}
