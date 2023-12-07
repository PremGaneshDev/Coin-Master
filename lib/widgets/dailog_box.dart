import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, int successCount) {
  Future.delayed(
    Duration.zero,
    () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.amber,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.amber,
              ).copyWith(
                secondary: Colors.amberAccent,
              ),
            ),
            child: AlertDialog(
              title: const Center(
                child: Text(
                  'Congratulations 🎉',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('You won total coins : $successCount'),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    child: const Text(
                      'OK',
                      style:
                          TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
