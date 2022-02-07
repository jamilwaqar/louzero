class MockJob {
  final String id;
  final String name;
  final String address;
  final String jobType;
  final String? fullName;
  final String? date;
  final double? total;
  MockJob(
      {required this.id,
      required this.name,
      required this.address,
      required this.jobType,
      this.fullName,
      this.date,
      this.total});
}
