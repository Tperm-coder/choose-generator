import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:untitled/components/functions/custom_pop_up_functions.dart';
import 'package:untitled/components/widgets/custom_button.dart';
import 'package:untitled/components/widgets/custom_text.dart';
import 'package:untitled/constants/constant_text.dart';
import 'package:untitled/constants/my_colors.dart';
import 'package:untitled/pages/home_page/home_page_provider.dart';

class UploadFileOption extends StatefulWidget {
  final HomePageProvider provider;
  const UploadFileOption({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  State<UploadFileOption> createState() => _UploadFileOptionState();
}

class _UploadFileOptionState extends State<UploadFileOption> {
  bool isHovering = false;
  double width = 650, height = 300;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyText.drawText(
              content: (!widget.provider.wasFileValidAndUploadedSuccessfully())
                  ? "No file was uploaded or the file uploaded format isn't supported"
                  : "A File was uploaded successfully, ready to generate questions",
              fontSize: 20,
              bold: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText.drawText(
              content: (widget.provider.uploadedFileName == "")
                  ? "................"
                  : widget.provider.uploadedFileName,
              fontSize: 15,
              bold: true,
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: DropzoneView(
                    onCreated: (DropzoneViewController controller) {
                      widget.provider.initDropFileController(controller);
                    },
                    onDrop: (e) {
                      setState(() {
                        isHovering = false;
                      });
                      widget.provider.onFileDropped(e);
                    },
                    onHover: () {
                      setState(() {
                        isHovering = true;
                      });
                    },
                    onLeave: () {
                      setState(() {
                        isHovering = false;
                      });
                    },
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: isHovering
                          ? Colors.green.shade200
                          : MyColors.selectedColor,
                      radius: const Radius.circular(15),
                      dashPattern: const [10, 5],
                      strokeWidth: 3,
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isHovering
                                ? Colors.green.shade200
                                : MyColors.lightBlueColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                color: isHovering
                                    ? Colors.white
                                    : MyColors.selectedColor,
                                size: 50,
                              ),
                              MyText.drawText(
                                content: "Drag your file",
                                fontSize: 20,
                                bold: true,
                                fontColor: isHovering
                                    ? Colors.white
                                    : MyColors.selectedColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomSimpleButton(
                                  onPress: () async {
                                    try {
                                      final fileEvent = await widget
                                          .provider.dropFileController
                                          .pickFiles();
                                      if (fileEvent.isEmpty) {
                                        return;
                                      }
                                      widget.provider
                                          .onFileDropped(fileEvent.first);
                                    } catch (e) {
                                      showSnackBarPopUp(context, ERROR_MESSAGE);
                                    }
                                  },
                                  label: ("Import file"),
                                  fontSize: 15,
                                  bgColor: isHovering
                                      ? Colors.green.shade200
                                      : MyColors.selectedColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
