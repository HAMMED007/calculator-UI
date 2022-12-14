import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/cupertino.dart';

import '../calculator.dart';

class RootScreenViewModel extends ChangeNotifier {
  List<Widget> allScreen = [
    Calculator(),
    ConverterScreen(),
  ];
  int selectedScreen = 0;

  updatedScreenIndex(int index) {
    selectedScreen = index;
    notifyListeners();
  }
}
