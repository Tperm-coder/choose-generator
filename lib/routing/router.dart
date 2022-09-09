import 'package:flutter/material.dart';
import 'package:untitled/components/widgets/error_widget.dart';
import 'package:untitled/pages/home_page/home_page.dart';
import 'package:untitled/pages/questions_page/questions_page.dart';

class CustomRouter {
  static void navigateTo(BuildContext context, String route,
      {Object args = const {}}) {
    Navigator.pushReplacement(
      context,
      navigateToLogic(
        RouteSettings(
          name: route,
          arguments: args,
        ),
      ),
    );
  }

  static Route navigateToLogic(RouteSettings settings) {
    if (settings.name == HomePage.route) {
      return MaterialPageRoute(builder: (_) => const HomePage());
    }
    if (settings.name == QuestionsPage.route) {
      List<dynamic> jsn;
      try {
        jsn = ((settings.arguments ?? {}) as Map<String, dynamic>)["data"];
      } catch (e) {
        // print("Error in the custom router");
        jsn = [];

        return MaterialPageRoute(builder: (_) => const CustomErrorWidget());
      }
      return MaterialPageRoute(
        builder: (_) => QuestionsPage(
          json: jsn,
        ),
      );
    }

    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
