import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/models/job_models.dart';
import 'package:uuid/uuid.dart';

void main() {

  setUp(() {});

  tearDown(() {});
  final jobObjectId = const Uuid().v4();

  Map<String, dynamic> billingJson = {
    'objectId': const Uuid().v4(),
    'jobId': jobObjectId,
    'quantity': 4.0,
    'price': 4.25,
    'description': 'description',
    'note': 'note',
    'subtotal': 0,
    'taxable': false,
    'addDiscount': false,
    'discountDescription': 'discountDescription',
    'isPercentDiscount': true,
    'discountAmount': 0.0,
  };

  test("BillingLineModel test", () {
    final billingLine = BillingLineModel.fromJson(billingJson);
    expect(billingLine.objectId, billingJson['objectId']);
    expect(billingLine.jobId, jobObjectId);
    expect(billingLine.price, 4.25);
  });

  test("ScheduleModel test", () {

  });

  test("JobModel test", () {
    String ownerId = const Uuid().v4();
    Map<String, dynamic> json = {
      'objectId': jobObjectId,
      'ownerId': ownerId,
      'jobType': 'Installation',
      'status': 'Estimate',
      'email': 'test@gmail.com',
      'jobId': 9253,
      'description': 'Need to fix something important at this job. It’s pretty complex so be prepared for that complexity.',
      'note': 'note',
      'ScheduleModel': [],
      'billingLineModels': []
    };

    final job = JobModel.fromMap(json);
    expect(job.objectId, jobObjectId);
    expect(job.ownerId, ownerId);
    expect(job.description, 'Need to fix something important at this job. It’s pretty complex so be prepared for that complexity.');
    expect(job.note, 'note');
    expect(job.jobId, 9253);
    expect(job.jobType, 'Installation');
    expect(job.status, 'Estimate');
  });
}
