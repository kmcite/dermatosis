import 'package:dermatosis/main.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';
import 'package:forui/forui.dart';

import '../patients/patient.dart';

class AddPatientDialogState {
  String name = '';
  String complaints = '';
}

class AddPatientDialogBloc {
  final stateRM = RM.inject(() => AddPatientDialogState());
  AddPatientDialogState get state => stateRM.state;
  set state(AddPatientDialogState state) {
    stateRM
      ..state = state
      ..notify(); // mutable state so notify is necessary
  }

  String name([String? name]) {
    if (name != null) {
      state = state..name = name;
    }
    return state.name;
  }

  String complaints([String? complaints]) {
    if (complaints != null) {
      state = state..complaints = complaints;
    }
    return state.complaints;
  }

  void yes() {
    final patient = Patient()
      ..name = state.name
      ..complaints = state.complaints;
    navigator.back(patient);
  }

  void cancel() => navigator.back();
}

final addPatientDialogBlocRM = RM.inject(() => AddPatientDialogBloc());

AddPatientDialogBloc get _bloc => addPatientDialogBlocRM.state;

class AddPatientDialog extends UI {
  const AddPatientDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: 'Patient'.text(),
      body: Column(
        children: [
          FTextField(
            label: Text('name'),
            initialValue: _bloc.name(),
            onChange: _bloc.name,
          ),
          FTextField(
            label: Text('complaints'),
            initialValue: _bloc.complaints(),
            onChange: _bloc.complaints,
            minLines: 6,
            maxLines: 15,
          ),
        ],
      ),
      actions: [
        FButton(
          onPress: _bloc.cancel,
          label: 'cancel'.text(),
        ),
        FButton(
          onPress: _bloc.yes,
          label: 'yes'.text(),
        ),
      ],
    );
  }
}
