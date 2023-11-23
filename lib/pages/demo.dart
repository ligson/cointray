import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class DemoPage extends StatefulWidget {
  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> with TrayListener {
  bool winShow = false;
  bool contextMenuInit = false;

  @override
  void initState() {
    trayManager.addListener(this);

    setState(() {
      _handleSetIcon();
    });

    super.initState();
  }

  void _initMenu() async {
    if (!contextMenuInit) {
      Menu _menu = Menu(
        items: [
          MenuItem(
            label: 'Look Up "LeanFlutter"',
          ),
          MenuItem.separator(),
          MenuItem(
            label: 'Search with Google',
          ),
          MenuItem.separator(),
          MenuItem(
            label: 'Cut',
          ),
        ],
      );
      print("init menu...");
      await trayManager.setContextMenu(_menu);
      contextMenuInit = true;
    }
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  void _handleSetIcon() async {
    String iconPath =
        Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.png';
    await trayManager.setIcon(iconPath);
  }

  @override
  Widget build(BuildContext context) {
    return Text("data");
  }

  @override
  void onTrayIconMouseDown() {
    print('onTrayIconMouseDown');
    _initMenu();
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconMouseUp() {
    print('onTrayIconMouseUp');
  }

  @override
  void onTrayIconRightMouseDown() {
    print('onTrayIconRightMouseDown');
    // trayManager.popUpContextMenu();
    if (winShow) {
      windowManager.hide();
      winShow = false;
    } else {
      windowManager.show();
      windowManager.focus();
      winShow = true;
    }
  }

  @override
  void onTrayIconRightMouseUp() {
    print('onTrayIconRightMouseUp');
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    print(menuItem.toJson());
    BotToast.showText(
      text: '${menuItem.toJson()}',
    );
  }
}
