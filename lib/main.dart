import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/map_screen.dart';
import '../screens/map_screen_2.dart';
import '../screens/map_screen_3.dart';
import '../screens/location_screen.dart';
import '../screens/location_screen_2.dart';
import '../screens/location_screen_3.dart';
import '../screens/location_screen_4.dart';
import '../screens/location_screen_5.dart';
import './providers/location_provider_2.dart';

void main() {
  runApp(NoGoogleMaps());
}

class NoGoogleMaps extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => LocationProvider2()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  MapScreen3(),
      ),
    );
  }
}
