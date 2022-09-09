import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/components/functions/custom_pop_up_functions.dart';
import 'package:untitled/components/page_template/page_template.dart';
import 'package:untitled/components/widgets/custom_button.dart';
import 'package:untitled/constants/constant_text.dart';
import 'package:untitled/constants/my_colors.dart';
import 'package:untitled/pages/home_page/home_page_provider.dart';
import 'package:untitled/pages/home_page/home_page_text_input_option.dart';
import 'package:untitled/pages/home_page/home_page_upload_file_option.dart';
import 'package:untitled/pages/questions_page/questions_page.dart';
import 'package:untitled/routing/router.dart';
import 'package:untitled/widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  static String route = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageProvider(context: context),
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      navIndex: 0,
      child: Consumer<HomePageProvider>(
        builder: (_, provider, __) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < provider.inputOptions.length; i++)
                        OptionTile(
                          title: provider.inputOptions[i],
                          onClick: () {
                            provider.setChosenOptionIndex(i);
                          },
                          isChosen: (i == provider.getChosenOptionIndex()),
                        ),
                    ],
                  ),
                ),
              ),
              provider.getChosenOptionIndex() == 0
                  ? TextInputOptions(
                      controller: provider.inputTextController,
                    )
                  : UploadFileOption(
                      provider: provider,
                    ),
              CustomSimpleButton(
                onPress: () async {
                  await provider.getJson().then(
                    (value) {
                      if (value.toString() != "{}") {
                        CustomRouter.navigateTo(
                          context,
                          QuestionsPage.route,
                          args: value,
                        );
                      } else {
                        showSnackBarPopUp(context, ERROR_MESSAGE);
                      }
                    },
                  );
                },
                label: ("generate Questions page"),
                fontSize: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}

class OptionTile extends StatefulWidget {
  OptionTile({
    Key? key,
    required this.title,
    required this.onClick,
    required this.isChosen,
  }) : super(key: key);

  final String title;
  final Function onClick;
  final bool isChosen;

  bool isHoveredOn = false;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: MouseRegion(
        onEnter: (e) {
          setState(() {
            widget.isHoveredOn = !widget.isHoveredOn;
          });
        },
        onExit: (e) {
          setState(() {
            widget.isHoveredOn = !widget.isHoveredOn;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: widget.isChosen
                  ? MyColors.selectedColor
                  : widget.isHoveredOn
                      ? MyColors.darkBlueColor
                      : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffe0e0e0),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: MyText.drawText(
                content: widget.title,
                fontColor: widget.isChosen
                    ? Colors.white
                    : widget.isHoveredOn
                        ? Colors.white
                        : MyColors.fontColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
