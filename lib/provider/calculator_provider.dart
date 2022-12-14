import 'package:calculator/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/imports.dart';
import 'package:flutter/widgets.dart';

import '../model/data_model.dart';

class CalculatorProvider with ChangeNotifier {
  String equation = '';
  String result = '';

  void addToEquation(String sign, bool canFirst, BuildContext context) {
    if (equation == '') {
      if (sign == '.') {
        equation = '0.';
      } else if (canFirst) {
        equation = sign;
      }
    } else {
      if (sign == "AC") {
        equation = '';
        result = '';
      } else if (sign == "⌫") {
        if (equation.endsWith(' ')) {
          equation = '${equation.substring(0, equation.length - 3)}';
        } else {
          equation = '${equation.substring(0, equation.length - 1)}';
        }
      } else if (equation.endsWith('.') && sign == '.') {
        return;
      } else if (equation.endsWith(' ') && sign == '.') {
        equation = equation + '0.';
      } else if (equation.endsWith(' ') && canFirst == false) {
        equation = '${equation.substring(0, equation.length - 3) + sign}';
      } else if (sign == '=') {
        sendDataToFirebase(result, equation, context);

        //   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      } else {
        equation = equation + sign;
      }
    }
    if (equation == '0') {
      equation = '';
    }
    try {
      var privateResult = equation.replaceAll('÷', '/').replaceAll('×', '*');
      Parser p = Parser();
      Expression exp = p.parse(privateResult);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
    } catch (e) {
      result = '';
    }
    notifyListeners();
  }
}

sendDataToFirebase(result, equation, context) async {
  String timeNow = DateTime.now().toString();
  try {
    await FirebaseFirestore.instance
        .collection('history')
        .doc(locator<GetDeviceId>().deviceId)
        .collection('Calculation')
        .doc(timeNow)
        .set({
      'title': result,
      'subtitle': equation,
      'dateTime': timeNow,
    });
    showToast(context, 'Saved');
  } catch (e) {
    print(e);
    showToast(context, 'Unable to save');
  }
}
