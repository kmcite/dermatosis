import 'package:dermatosis/main.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';
import 'package:dermatosis/patients/patient.dart';
import 'package:dermatosis/patients/patient_page.dart';
import 'package:forui/forui.dart';

class PatientTile extends UI {
  final Patient patient;

  PatientTile({super.key, required this.patient});
  @override
  Widget build(BuildContext context) {
    return FLabel(
      axis: Axis.vertical,
      label: patient.name.text(),
      description: Text('${patient.complaints}'),
      child: FButton(
        onPress: () => navigator.to(
          PatientPage(patient.id),
        ),
        child: Icon(Icons.info),
      ),
    );
  }
}
