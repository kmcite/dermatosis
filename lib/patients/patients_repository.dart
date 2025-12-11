// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dermatosis/main.dart';
import 'package:dermatosis/patients/patient.dart';

PatientsRepository get patientsRepository => patientRepositoryRM.state;
final patientRepositoryRM = RM.inject(() => PatientsRepository());

class PatientsRepository with CRUD<Patient> {
  Patient? search(String email) =>
      getAll().where((patient) => patient.email == email).firstOrNull;
}

mixin CRUD<M> {
  final box = store.box<M>();
  late final query = box.query;
  late final get = box.get;
  late final getAll = box.getAll;
  late final getAllAsync = box.getAllAsync;
  late final remove = box.remove;
  late final removeAll = box.removeAll;
  late final removeAllAsync = box.removeAllAsync;
  late final put = box.put;
  late final watch =
      () => query().watch(triggerImmediately: true).map((s) => s.find());
}
