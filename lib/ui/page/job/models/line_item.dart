class LineItem {
  final String id;
  final String description;
  final double count;
  final double price;
  final double subtotal;
  final String? note;
  final double? discount;
  final String? discountText;
  final String? inventoryId;

  const LineItem({
    required this.id,
    required this.description,
    required this.count,
    required this.price,
    required this.subtotal,
    this.note,
    this.discount,
    this.discountText,
    this.inventoryId,
  });
}
