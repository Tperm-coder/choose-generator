import 'package:flutter/material.dart';
import 'package:untitled/components/wrappres/card_wrapper.dart';
import 'package:untitled/constants/my_colors.dart';
import 'package:untitled/constants/ratios.dart';
import 'package:untitled/widgets/custom_text.dart';

import 'page_template_content.dart';

class PageTemplate extends StatelessWidget {
  final int navIndex;
  final Widget child;
  const PageTemplate({
    Key? key,
    required this.child,
    required this.navIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cardColor,
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              Column(
                children: [
                  CardWrapper(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          (navBarWidthRatio / 100),
                      child: const CardWrapper(
                        child: SizedBox(
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CardWrapper(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          (navBarWidthRatio / 100),
                      child: SideNavBar(
                        navIndex: navIndex,
                      ),
                    ),
                  ),
                ],
              ),
              CardWrapper(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                          ((100 - 2 * navBarWidthRatio) / 100) -
                      120,
                  child: child,
                ),
              ),
              CardWrapper(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      (navBarWidthRatio / 100),
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideNavBar extends StatelessWidget {
  final int navIndex;
  const SideNavBar({
    Key? key,
    required this.navIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          for (int i = 0; i < navTitle.length; i++)
            NavBarTile(
              activeIndex: navIndex,
              index: i,
            ),
        ],
      ),
    );
  }
}

class NavBarTile extends StatefulWidget {
  final int index;
  final int activeIndex;
  NavBarTile({
    Key? key,
    required this.index,
    required this.activeIndex,
  }) : super(key: key);
  bool isSelected = false;

  @override
  State<NavBarTile> createState() => _NavBarTileState();
}

class _NavBarTileState extends State<NavBarTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
              context, navTitleRoute[navTitle[widget.index] ?? ""] ?? "");
        },
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              widget.isSelected = true;
            });
          },
          onExit: (event) {
            setState(() {
              widget.isSelected = false;
            });
          },
          child: Row(
            children: [
              Icon(
                navIconList[widget.index],
                color: (widget.activeIndex == widget.index)
                    ? MyColors.selectedColor
                    : widget.isSelected
                        ? MyColors.darkBlueColor
                        : MyColors.fontColor,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: MyText.drawText(
                  content: navTitle[widget.index],
                  fontSize: 15,
                  fontColor: (widget.activeIndex == widget.index)
                      ? MyColors.selectedColor
                      : widget.isSelected
                          ? MyColors.darkBlueColor
                          : MyColors.fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
