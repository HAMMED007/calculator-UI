import 'package:flutter/material.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mile Converter'),
        centerTitle: true,
      ),
      body: Center(child: Text('Mile Converter Screen. You said just screen',style: TextStyle(color: Colors.white),),),
    );
  }
}
