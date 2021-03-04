
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_doctor/Services/Auth.dart';
import 'package:rock_doctor/common_widgets/show_alert_dialog.dart';

import 'image_labler.dart';


class HomePage extends StatelessWidget {


  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toSring());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'logout',
      content: 'Are you sure that you want to logout',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rock Doc'),
          actions: <Widget>[
            FlatButton(
              child: Text('Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  )),
              onPressed: () => _confirmSignOut(context),
            )
          ],
        ),
        body: Center(
          child: HomeScreen(),
        ),
    );
  }
}

