import 'package:calculator/locator.dart';
import 'package:calculator/provider/calculator_provider.dart';
import 'package:calculator/screens/history.dart';
import 'package:calculator/screens/root/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:calculator/imports.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(HistoryItemAdapter());
  // await Hive.openBox<HistoryItem>('history');

  await Firebase.initializeApp(
    name: 'calculator',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (_) => CalculatorProvider(),
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: backgroundColor,
                appBarTheme: AppBarTheme(
                  color: backgroundColor,
                  elevation: 0.0,
                ),
                textTheme: TextTheme(
                  headline3: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  caption: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    fontSize: 18.0,
                  ),
                ),
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: yellowColor),
              ),
              routes: {
                '/': (context) => RootScreen(),
                '/history': (context) => History(),
              },
            );
          }),
    );
  }
}
