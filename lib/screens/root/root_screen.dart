import 'package:calculator/screens/root/root_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootScreenViewModel(),
      child: Consumer<RootScreenViewModel>(
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async {
            final status = await Get.dialog(AlertDialog(
              title: const Text('Caution!'),
              content:
                  const Text('Do you really want to close the application?'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: const Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: const Text('No'),
                ),
              ],
            ));


            return status;
          },
          child: Scaffold(
              extendBody: true,
              body: model.allScreen[model.selectedScreen],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(1, 1))
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    iconSize: 25,
                    unselectedItemColor: Colors.grey,
                    selectedIconTheme:
                        IconThemeData(color: Colors.deepPurpleAccent),
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.calculate_outlined,
                        ),
                        label: 'Calculator',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.timer),
                        label: 'Converter',
                      ),
                    ],
                    currentIndex: model.selectedScreen,
                    selectedItemColor: Colors.amber[800],
                    onTap: model.updatedScreenIndex,
                  ),
                ),
              )

//      body: _list[_page],

              ),
        ),
      ),
    );
  }
}
