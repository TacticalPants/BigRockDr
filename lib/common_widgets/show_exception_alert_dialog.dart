import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rock_doctor/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
    BuildContext context, {

      @required String title,
      @required Exception exception,
    }) =>
    showAlertDialog(
      context,
      title: title,
      content: exception.toString(),
      defaultActionText: 'OK',
    );
String message(Exception exception){
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}

