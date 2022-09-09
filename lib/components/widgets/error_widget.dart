import 'package:flutter/material.dart';
import 'package:untitled/components/widgets/custom_button.dart';
import 'package:untitled/pages/home_page/home_page.dart';
import 'package:untitled/routing/router.dart';
import 'package:untitled/widgets/custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red.shade200,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: MyText.drawText(
                content: "An Error Occurred while parsing the input",
                fontSize: 30,
              ),
            ),
            CustomSimpleButton(
              label: "HomePage",
              onPress: () {
                CustomRouter.navigateTo(
                  context,
                  HomePage.route,
                );
              },
              fontSize: 25,
            )
          ],
        ),
      ),
    );
  }
}
