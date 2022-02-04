import 'package:flutter/material.dart';
import 'package:flutter_gen_utils_web/ui/default_screen.dart';
import 'package:flutter_gen_utils_web/ui/home.dart';
import 'package:flutter_gen_utils_web/ui/json_to_dart_serialization.dart';

class RouteGenerator {
  static var routeMap = <String, WidgetBuilder>{

    Home.routeName : (context) => Home(),
    JsonToDartSerialization.routeName : (context) => JsonToDartSerialization(),
  };

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case RouteNames.deviceCommandReport:
      //   Map<String, dynamic> args = routeSettings.arguments as Map<String, dynamic>;
      //   debugPrint('Route Genetator: DeviceCommandReport args=$args') ;
      //   return MaterialPageRoute(
      //       builder: (context) => DeviceCommandReport(reportType: args['report_type'],vehicle: args['vehicle'], imMob: args['immobilizer'],)
      //   );
      //
      // case RouteNames.reports:
      //   Map<String, dynamic> args = routeSettings.arguments as Map<String, dynamic>;
      //   debugPrint('Route Genetator: Reports args=$args') ;
      //   return MaterialPageRoute(
      //       builder: (context) => VehicleReport(reportType: args['report_type'],vehicle: args['vehicle'], sensors: args['sensors'], imMob: args['immobilizer'],)
      //   );

      default:
        return MaterialPageRoute(builder: (context) => DefaultScreen(content: 'Unknown Page'));
    }
  }

}
