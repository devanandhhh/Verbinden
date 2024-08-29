import 'package:flutter/material.dart';
import 'package:verbinden/data/api/websocket_repo/websocket_repo.dart';

import '../../../../core/colors_constant.dart';
import '../../../../data/shared_preference/shared_preference.dart';
import '../../BottomNavigation/widgets/bottom_nav_widget.dart';
import '../../auth/LoginPage/login_page.dart';
import '../../auth/widgets/authwidgets.dart';
import '../../profile/widgets/widgets.dart';

Future<dynamic> dialogForDelete(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'Do You Want to Logout',
        style: gPoppines15,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: gPoppines15,
            )),
        TextButton(
            onPressed: () async {
              await SharedPreference.saveboolValue(false);
              //channel?.sink.close();
              WebsocketService().closeConnection();
              Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (ctx) => LoginPage()),
                  (route) => false);
              selectedIndex = ValueNotifier<int>(0);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                  kSnakbar(text: 'LogOut succesfully', col: ksnackbarGreen));
            },
            child: Text(
              'Yes',
              style: gPoppines15,
            )),
      ],
    ),
  );
}

Text textFontsize_20(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 20,
    ),
  );
}
