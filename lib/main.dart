import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvelapp/app/app_widget.dart';
import 'package:marvelapp/app/core/style/assets.dart';

import 'app/app_module.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    await Hive.initFlutter();
    await Hive.openBox('marvel');
    await Future.wait([
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, AssetsMarvel.shield),
        null,
      ),
    ]);
    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}
