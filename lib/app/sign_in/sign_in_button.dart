import 'package:flutter/cupertino.dart';
import 'package:rock_doctor/common_widgets/custon_raised_button.dart';


class SignInButton extends CustomRaisedButton{
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) :   assert(text !=null),
        super(
        child: Text(text, style: TextStyle(color: textColor, fontSize: 15.0),
        ),
        color: color,
        borderRadius: 8.0,
        onPressed: onPressed,
      );
}