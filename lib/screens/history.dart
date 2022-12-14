import 'package:calculator/locator.dart';
import 'package:calculator/imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/data_model.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'History',
        Icons.auto_delete_outlined,
        () async {
          // delete history from firebase Firestore
          try {
            await FirebaseFirestore.instance
                .collection('history')
                .doc(locator<GetDeviceId>().deviceId)
                .collection('Calculation')
                .get()
                .then((snapshot) {
              for (DocumentSnapshot ds in snapshot.docs) {
                ds.reference.delete();
              }
            });

            showToast(context, 'History cleared successfully');
          } catch (e) {
            print(e.toString());
            showToast(context, 'Error clearing history');
            Navigator.pop(context);
          }
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('history')
            .doc(locator<GetDeviceId>().deviceId)
            .collection('Calculation')
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.docs.length != 0
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          tileColor: buttonsBackgroundColor,
                          title: Text(
                            snapshot.data.docs[index]['title'],
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 26.0),
                          ),
                          subtitle: Text(
                            snapshot.data.docs[index]['subtitle'],
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 20.0),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  );
          } else {
            return Center(
              child: Text(
                'No History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
