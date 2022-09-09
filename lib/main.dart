import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:untitled/components/widgets/error_widget.dart';
import 'package:untitled/pages/home_page/home_page.dart';

void main() {
  ErrorWidget.builder =
      (FlutterErrorDetails details) => const CustomErrorWidget();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.autoScale(
            100,
            name: MOBILE,
            scaleFactor: 0.06,
          ),
          ResponsiveBreakpoint.autoScale(
            450,
            name: DESKTOP,
            scaleFactor: 0.29,
          ),
          ResponsiveBreakpoint.autoScale(
            600,
            name: TABLET,
            scaleFactor: 0.38,
          ),
          ResponsiveBreakpoint.autoScale(
            800,
            name: DESKTOP,
            scaleFactor: 0.5,
          ),
          ResponsiveBreakpoint.autoScale(
            1700,
            name: "XL",
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
