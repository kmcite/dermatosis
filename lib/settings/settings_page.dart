import 'package:forui/forui.dart';

import '../authentication/authentication_bloc.dart';
import '../main.dart';
import '../navigation/navigation_bloc.dart';

class SettingsPage extends UI {
  const SettingsPage({super.key});
  @override
  Widget build(context) {
    return FScaffold(
      header: FHeader(
        title: const Text('settings'),
        actions: [
          FButton.icon(
            onPress: () => navigator.back(),
            child: Icon(Icons.arrow_back_ios),
          ),
          FButton.icon(
            onPress: () {
              authenticationBloc.logout();
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      content: ListView(
        children: [
          // ShadSelect<ThemeMode>(
          //   placeholder: Text('ThemeMode'),
          //   initialValue: settingsBloc.themeMode(),
          //   options: ThemeMode.values.map(
          //     (themeMode) => ShadOption(
          //       value: themeMode,
          //       child: themeMode.name.text(),
          //     ),
          //   ),
          //   selectedOptionBuilder: (context, value) {
          //     return Text(value.name);
          //   },
          //   onChanged: settingsBloc.themeMode,
          // ),
          FTextField(
            label: Text('clinic/hospital name'),
            initialValue: settingsBloc.clinicName,
            onChange: settingsBloc.setClinicName,
          ),
        ],
      ),
    );
  }
}
