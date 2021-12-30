class LineItem {
  final String description;
  final double count;
  final double price;
  final double subtotal;
  final String? note;

  const LineItem({
    required this.description,
    required this.count,
    required this.price,
    required this.subtotal,
    this.note,
  });

  LineItem copy({
    String? description,
    double? count,
    double? price,
    double? subtotal,
  }) =>
      LineItem(
        description: description ?? this.description,
        count: count ?? this.count,
        price: price ?? this.price,
        subtotal: subtotal ?? this.subtotal,
      );
}
