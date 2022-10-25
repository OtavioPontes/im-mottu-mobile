// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvelapp/app/app_controller.dart';
import 'package:marvelapp/app/app_module.dart';
import 'package:marvelapp/app/core/extensions/screen_extension.dart';
import 'package:marvelapp/app/core/style/theme.dart';

import 'core/screen/design_ui.dart';
import 'core/screen/screen_util.dart';

class AppWidget extends StatefulWidget {
  const AppWidget();

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppController controller = Modular.get<AppController>();

  @override
  void dispose() {
    controller.dispose();
    Modular.destroy();
    super.dispose();
  }

  static const stream = EventChannel("unique.identifier.method/stream");

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(AppModule.routeName);
    return ScreenUtil.builder(
      designUI: DesignUI.androidMaterial,
      designUITablet: DesignUI.androidMaterial,
      builder: (context, constraints, orientation) {
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: 'Marvel App',
          builder: (context, child) {
            final Size size = MediaQuery.of(context).size;
            return StreamBuilder(
                stream: stream.receiveBroadcastStream(),
                builder: (context, snapshot) {
                  return SafeArea(
                    child: Scaffold(
                      body: child,
                      appBar: snapshot.data == false
                          ? NoInternetBanner(
                              size: Size(
                                size.width,
                                100.scale,
                              ),
                            )
                          : null,
                    ),
                  );
                });
          },
          theme: ThemesMarvel.light,
        );
      },
    );
  }
}

class NoInternetBanner extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  const NoInternetBanner({
    Key? key,
    required this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: size.height,
      color: theme.errorColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            size: 40.scale,
            color: theme.colorScheme.onSecondary,
          ),
          SizedBox(
            width: 32.scale,
          ),
          Text(
            'network connection not avaliable',
            style: theme.textTheme.headline6!.merge(
              TextStyle(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(size.width, 80);
}
