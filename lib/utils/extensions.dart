import 'package:dermatosis/main.dart';

extension Xtensive on dynamic {
  Widget text() => Text(this.toString());
}

extension Xtenssive on Widget {
  Widget pad({EdgeInsets? padding}) => Padding(
        padding: padding ?? EdgeInsets.all(8),
        child: this,
      );
}
