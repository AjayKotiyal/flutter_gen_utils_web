import 'package:flutter/material.dart';

class StaticAlertContent extends StatelessWidget {
  final String? title,
      message,
      positiveActionCaption,
      negativeActionCaption,
      neutralActionCaption;
  VoidCallback? positiveAction, negativeAction, neutralAction;
  final Widget? extendedWidget;
  bool? actionRequired;

  StaticAlertContent({
    Key? key,
    this.title,
    this.message,
    this.positiveActionCaption = "OK",
    this.positiveAction,
    this.negativeActionCaption,
    this.negativeAction,
    this.neutralActionCaption,
    this.neutralAction,
    this.extendedWidget,
    this.actionRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    positiveAction ??= () => Navigator.pop(context);
    if (negativeActionCaption != null && negativeAction == null) {
      negativeAction = () => Navigator.pop(context);
    }
    if (neutralActionCaption != null && neutralAction == null) {
      neutralAction = () => Navigator.pop(context);
    }
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null)
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange, // todo: change color
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                ),
                child: Text(
                  "$title",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 1.0),
                ),
              ),
            SizedBox(
              height: 16.0,
            ),
            if (message != null)
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Column(
                  children: [
                    Text(
                      "$message",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            if (extendedWidget != null)
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Column(
                  children: [
                    extendedWidget!,
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            if (actionRequired!)
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (negativeActionCaption != null)
                      ElevatedButton(
                        child: Text(
                          "$negativeActionCaption",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: negativeAction,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange), // todo: change color to colorConfig.negativeBtnBackground
                      ),
                    if (neutralActionCaption != null)
                      ElevatedButton(
                        child: Text("$neutralActionCaption",
                            style: TextStyle(color: Colors.white)),
                        onPressed: neutralAction,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange), // todo: change color to colorConfig.neutralBtnBackground
                      ),
                    ElevatedButton(
                      child: Text("$positiveActionCaption", style: TextStyle(color: Colors.white)),
                      onPressed: positiveAction,
                      style:
                      ElevatedButton.styleFrom(primary: Colors.deepOrange), // todo: change color
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}

