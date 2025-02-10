import 'package:dermatosis/authentication/authentication_bloc.dart';
import 'package:dermatosis/authentication/authentication_page.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';
import 'package:dermatosis/objectbox.g.dart';
import 'package:forui/forui.dart';

import 'main.dart';

export 'dart:async';
export 'dart:io';

export 'package:dermatosis/home/home_page.dart';
export 'package:dermatosis/settings/settings_bloc.dart';
export 'package:manager/manager.dart';
export 'package:path_provider/path_provider.dart';
export 'package:states_rebuilder/states_rebuilder.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final appInfo = await PackageInfo.fromPlatform();
  final path = await getApplicationDocumentsDirectory();
  store = await openStore(
    directory: join(
      path.path,
      appInfo.appName,
    ),
  );

  await RM.storageInitializer(HiveStorage());
  runApp(App());
}

class App extends UI {
  @override
  void didMountWidget(BuildContext context) => FlutterNativeSplash.remove();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator.key,
      debugShowCheckedModeBanner: false,
      themeMode: settingsBloc.themeMode(),
      builder: (context, child) => FTheme(
        data: FThemes.yellow.light,
        child: child!,
      ),
      home: authenticationBloc.isAuthenticated
          ? HomePage()
          : AuthenticationPage(),
    );
  }
}

extension DurationExtensions on Duration {
  String get formatDuration {
    final years = inDays ~/ 365;
    final months = (inDays % 365) ~/ 30;
    final days = (inDays % 365) % 30;
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (years > 0) {
      return '$years years';
    } else if (months > 0) {
      return '$months months';
    } else if (days > 0) {
      return '$days days';
    } else if (hours > 0) {
      return '$hours hours';
    } else if (minutes > 0) {
      return '$minutes minutes';
    } else {
      return '$seconds seconds';
    }
  }

  String get inYears => '${(this.inDays / 365).ceil()}';
}
