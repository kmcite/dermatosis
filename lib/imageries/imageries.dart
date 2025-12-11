import 'dart:typed_data';

import 'package:dermatosis/objectbox.g.dart';

import '../main.dart';

@Entity()
class Imagery {
  @Id()
  int id = 0;
  String path = '';

  @Transient()
  Uint8List? get image {
    try {
      return File(this.path).readAsBytesSync();
    } catch (e) {
      return null;
    }
  }
}
