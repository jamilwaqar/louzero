class Supplier {
  final String name;

  const Supplier({
    required this.name,
  });

  Supplier copy({
    String? name,
  }) =>
      Supplier(
        name: name ?? this.name,
      );
}
