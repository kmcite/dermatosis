import 'package:dermatosis/authentication/authentication_bloc.dart';
import 'package:dermatosis/main.dart';
import 'package:forui/forui.dart';

class AuthenticationPage extends UI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          children: [
            FTabs(
              initialIndex: authenticationBloc.tabIndex,
              onPress: authenticationBloc.setTabIndex,
              children: [
                FTabEntry(
                  label: 'DOCTOR'.text(),
                  child: FLabel(
                    child: Column(
                      children: [
                        FTextField(
                          label: 'name'.text(),
                          initialText: authenticationBloc.authentication.name,
                          onChange: authenticationBloc.onNameChange,
                        ).pad(),
                        FTextField.email(
                          initialText: authenticationBloc.authentication.email,
                          onChange: authenticationBloc.onEmailChange,
                        ).pad(),
                        FTextField.password(
                          initialText:
                              authenticationBloc.authentication.password,
                          onChange: authenticationBloc.onPasswordChange,
                        ).pad(),
                      ],
                    ),
                    axis: Axis.vertical,
                  ),
                ),
                FTabEntry(
                  label: 'PATIENT'.text(),
                  child: Column(
                    children: [
                      FTextField(
                        label: 'name'.text(),
                        initialText: authenticationBloc.authentication.name,
                        onChange: authenticationBloc.onNameChange,
                      ).pad(),
                      FTextField.email(
                        initialText: authenticationBloc.authentication.email,
                        onChange: authenticationBloc.onEmailChange,
                      ).pad(),
                      FTextField.password(
                        initialText: authenticationBloc.authentication.password,
                        onChange: authenticationBloc.onPasswordChange,
                      ).pad(),
                    ],
                  ),
                ),
              ],
            ),
            FButton(
              child: const Text('Login'),
              onPress: authenticationBloc.invalidCredentials
                  ? null
                  : () {
                      authenticationBloc.userType(UserType.patient);
                      authenticationBloc.login();
                    },
            ).pad(),
          ],
        ),
      ),
    );
  }
}
