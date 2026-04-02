import 'package:dermatosis/authentication/authentication_bloc.dart';
import 'package:dermatosis/authentication/authentication_page.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';
import 'package:dermatosis/objectbox.g.dart';
export 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
export 'package:dermatosis/utils/extensions.dart';

import 'main.dart';

export 'dart:async';
export 'dart:io';

export 'package:dermatosis/home/home_page.dart';
export 'package:dermatosis/settings/settings_bloc.dart';
export 'package:path_provider/path_provider.dart';
export 'package:states_rebuilder/states_rebuilder.dart';

late final Store store;

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final path = await getApplicationDocumentsDirectory();
  store = await openStore(directory: join(path.path, appInfo.appName));

  // await RM.storageInitializer(HiveStorage());
  runApp(App());
}

typedef UI = ReactiveStatelessWidget;

class App extends UI {
  @override
  void didMountWidget(BuildContext context) => FlutterNativeSplash.remove();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator.key,
      debugShowCheckedModeBanner: false,
      themeMode: settingsBloc.themeMode(),
      builder: (context, child) =>
          FTheme(data: FThemes.yellow.light, child: child!),
      home: !authenticationBloc.isAuthenticated
          ? HomePage()
          : AuthenticationPage(),
    );
  }
}
