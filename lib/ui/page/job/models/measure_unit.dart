class MeasureUnit {
  final List<String> weight;
  const MeasureUnit({
    this.weight = const [
      'Ounce',
      'Pound',
      'Ton',
      'Kilogram',
      'Gram',
      'Milligram'
    ],
  });

  MeasureUnit copy({
    List<String>? weight,
  }) =>
      MeasureUnit(
        weight: weight ?? this.weight,
      );
}
