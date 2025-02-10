import 'package:dermatosis/imageries/imageries.dart';

import '../main.dart';

@Entity()
class Patient {
  @Id()
  int id = 0;
  String name = '';
  String complaints = '';
  String management = '';
  String diagnosis = '';

  bool gender = false; // true -> male
  bool editing = false;
  final address = ToOne<Address>();
  @Property(type: PropertyType.date)
  DateTime dateOfBirth = DateTime.now();
  @Property(type: PropertyType.date)
  DateTime presentation = DateTime.now();
  @Property(type: PropertyType.date)
  late DateTime modifiedOn = presentation;
  final contact = ToOne<Contact>();
  final lesions = ToMany<Lesion>();
  final images = ToMany<Imagery>();

  String email = 'adn@gmail.com';

  @Transient()
  Duration get age => DateTime.now().difference(dateOfBirth);

  @Transient()
  @override
  String toString() {
    return 'Patient{name: $name, gender: $gender, editing: $editing, address: $address, dateOfBirth: $dateOfBirth, contact: $contact, diagnosis: $diagnosis, lesions: $lesions, images: $images, age: $age}';
  }
}

final lesionsRepository = LesionsRepository();

class LesionsRepository with CRUD<Lesion> {}

final lesionsRM = LesionsBloc();

class LesionsBloc {
  final lesionsRM = RM.injectStream(
    () => lesionsRepository.watch(),
    initialState: lesionsRepository.getAll(),
  );
  List<Lesion> get lesions => lesionsRM.state;
  void put(Lesion lesion) => lesionsRepository.put(lesion);
}

@Entity()
class Lesion {
  @Id()
  int id = 0;
  String patterns = '';
}

@Entity()
class Contact {
  @Id()
  int id = 0;
  String countryCode = '';
  String mnp = '';
  String phoneCode = '';
}

@Entity()
class Address {
  @Id()
  int id = 0;
  String town = '';
  String city = '';
  String province = '';
  String country = '';

  String get address => "$town, $city, $province, $country";
}
