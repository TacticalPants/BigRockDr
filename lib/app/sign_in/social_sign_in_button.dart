import 'package:flutter/cupertino.dart';
import 'package:rock_doctor/common_widgets/custon_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) :  assert(assetName !=null),
        assert(text !=null),
        super(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(assetName),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            Opacity(
                opacity: 0.0,
                child: Image.asset(assetName)),
          ],
        ),
        borderRadius: 8.0,
        onPressed: onPressed,
      );
}