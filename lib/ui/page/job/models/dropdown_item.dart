import 'package:louzero/ui/page/job/models/supplier.dart';

class DropdownItem {
  final String name;
  final String? value;
  final dynamic data;

  const DropdownItem({
    required this.name,
    required this.value,
    this.data,
  });
}
