
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Utils {

  static String formatDate(DateTime? date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date ?? DateTime.now());
  }
  static  calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static showPickImageOptionsDialog(
      BuildContext context, {
        required VoidCallback onCameraTap,
        required VoidCallback onGalleryTap,
      }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: onCameraTap,
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalleryTap,
            child: const Text("Gallery"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
