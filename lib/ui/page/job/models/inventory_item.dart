import 'package:louzero/ui/page/job/models/supplier.dart';

class InventoryItem {
  final String id;
  final String description;
  final double price;
  final bool taxable;
  final bool discontinued;
  final String? note;
  // final double category;
  // final String measure;
  // final double cost;
  // final double profit;
  // final double margin;
  // final double markup;
  // final Supplier supplier;
  // final double partNumber;
  // final double accountingCode;

  const InventoryItem({
    required this.id,
    required this.description,
    required this.price,
    this.taxable = true,
    this.discontinued = false,
    this.note,
    // required this.category,
    // required this.measure,
    // required this.cost,
    // required this.profit,
    // required this.margin,
    // required this.markup,
    // required this.supplier,
    // required this.partNumber,
    // required this.accountingCode,
  });
}
