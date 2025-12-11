import 'package:dermatosis/imageries/patient_tile.dart';
import 'package:dermatosis/main.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';
import 'package:dermatosis/patients/patients_bloc.dart';
import 'package:forui/forui.dart';

class PatientsPage extends UI {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('dermatoma'),
        suffixes: [
          FHeaderAction.back(onPress: navigator.back),
        ],
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: patientsBloc.patients.length,
        itemBuilder: (context, index) => PatientTile(
          patient: patientsBloc.patients[index],
        ),
      ),
    );
  }
}
