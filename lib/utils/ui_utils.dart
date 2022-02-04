import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen_utils_web/ui/widgets/static_alert_content.dart';

class UIUtils {
  static Future? displaySnackbar(BuildContext context, String item,
      {SnackBarAction? action}) //, GlobalKey<ScaffoldState> containerKey
  {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      var snackBar = SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // added : 31-Mar-2021
        content: Text("$item"),
        action: action,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  /// to show a message dialog
  static Future alert(
      BuildContext context, {
        String? title,
        String? msg,
        String positiveActionCaption = "Ok",
        Function()? positiveAction,
        String? negativeActionCaption,
        Function()? negativeAction,
        String? neutralActionCaption,
        Function()? neutralAction,
        Widget? extendedWidget,
        bool closeOnPop = true, // like when press back button
        bool dissmisableFromOutsideTap = false,
        bool actionRequired = true,
      }) async {
    if (positiveAction == null){
      positiveAction = () => Navigator.pop(context);
    }
    if (negativeActionCaption != null && negativeAction == null) {
      negativeAction = () => Navigator.pop(context);
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => closeOnPop,
        child: StaticAlertContent(
          title: title,
          message: msg,
          positiveActionCaption: positiveActionCaption,
          positiveAction: positiveAction,
          negativeActionCaption: negativeActionCaption,
          negativeAction: negativeAction,
          neutralActionCaption: neutralActionCaption,
          neutralAction: neutralAction,
          extendedWidget: extendedWidget,
          actionRequired: actionRequired,
          // closeOnBackPressed: closeOnBackPressed,
        ),
      ),
      barrierDismissible: dissmisableFromOutsideTap,
    );
  }
}