import 'dart:convert';
import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:untitled/components/functions/custom_pop_up_functions.dart';
import 'package:untitled/constants/constant_text.dart';

class HomePageProvider extends ChangeNotifier {
  BuildContext context;
  HomePageProvider({required this.context}) : super();

  List<String> inputOptions = [
    "Input Text",
    "Upload Json",
    "Upload img",
    "Manual Input",
  ];
  final List<String> _validExtensions = [
    "png",
    "jpg",
    "json",
  ];
  late DropzoneViewController dropFileController;
  late dynamic lastFileEvent;
  String uploadedFileName = "";

  void initDropFileController(DropzoneViewController controller) {
    dropFileController = controller;
  }

  Future<void> onFileDropped(dynamic fileEvent) async {
    try {
      String name = await dropFileController.getFilename(fileEvent);
      uploadedFileName = name;
      lastFileEvent = fileEvent;
      notifyListeners();
    } catch (e) {
      showSnackBarPopUp(context, ERROR_MESSAGE);
      notifyListeners();
    }
  }

  String purifyJsonString(String str) {
    String purifiedJson = "";

    int openCount = 0;
    for (int i = 0; i < str.length; i++) {
      if (str[i] == '{') {
        openCount++;
      } else if (str[i] == '}') {
        openCount--;
      }
      if (openCount > 0) {
        purifiedJson += str[i];
      }
    }
    purifiedJson += '}';

    return purifiedJson.trim();
  }

  bool _isValidExtension() {
    return _validExtensions.contains(uploadedFileName.split('.')[1]);
  }

  bool wasFileValidAndUploadedSuccessfully() {
    return (!(uploadedFileName == "") && (_isValidExtension()));
  }

  int _chosenOptionIndex = 0;
  TextEditingController inputTextController = TextEditingController();

  void setChosenOptionIndex(int index) {
    if (0 <= index && index <= inputOptions.length) {
      _chosenOptionIndex = index;
      notifyListeners();
    }
  }

  int getChosenOptionIndex() {
    return _chosenOptionIndex;
  }

  Map<String, dynamic> getJsonFromTextController() {
    try {
      return json.decode(inputTextController.text.toString().trim());
    } catch (e) {
      showSnackBarPopUp(context, ERROR_MESSAGE);
      return {};
    }
  }

  Future<Map<String, dynamic>> getJsonFromDroppedFile() async {
    if (_isValidExtension()) {
      try {
        Uint8List fileBytes =
            await dropFileController.getFileData(lastFileEvent);
        String jsonString = File.fromRawPath(fileBytes).toString();
        jsonString = purifyJsonString(jsonString);
        return json.decode(jsonString);
      } catch (e) {
        showSnackBarPopUp(context, ERROR_MESSAGE);
        return {};
      }
    }
    return {};
  }

  Future<Map<String, dynamic>> getJson() async {
    if (_chosenOptionIndex == 0) {
      return getJsonFromTextController();
    }
    if (_chosenOptionIndex == 1) {
      return await getJsonFromDroppedFile();
    }
    return {};
  }
}
