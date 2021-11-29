export 'decoration.dart';

extension StringEx on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}