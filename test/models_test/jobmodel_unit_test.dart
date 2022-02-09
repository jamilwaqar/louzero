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

  Map<String, dynamic> scheduleJson = {
    'objectId': const Uuid().v4(),
    'startTime': 1643748083,
    'endTime': 1643748083,
    'note': 'note',
    'personnelId': 'personnelId',
    'complete': true,
    'personnelName': 'personnelName',
    'anyTimeVisit': true,
  };

  test("BillingLineModel test", () {
    final billingLine = BillingLineModel.fromJson(billingJson);
    expect(billingLine.objectId, billingJson['objectId']);
    expect(billingLine.jobId, jobObjectId);
    expect(billingLine.quantity, 4.0);
    expect(billingLine.price, 4.25);
    expect(billingLine.description, 'description');
    expect(billingLine.note, 'note');
    expect(billingLine.subtotal, 0);
    expect(billingLine.taxable, false);
    expect(billingLine.addDiscount, false);
    expect(billingLine.discountDescription, 'discountDescription');
    expect(billingLine.isPercentDiscount, true);
    expect(billingLine.discountAmount, 0.0);
  });

  test("ScheduleModel test", () {
    final schedule = ScheduleModel.fromJson(scheduleJson);
    expect(schedule.objectId, scheduleJson['objectId']);
    expect(schedule.startTime, 1643748083);
    expect(schedule.endTime, 1643748083);
    expect(schedule.note, 'note');
    expect(schedule.personnelId, 'personnelId');
    expect(schedule.note, 'note');
    expect(schedule.complete, true);
    expect(schedule.personnelName, 'personnelName');
    expect(schedule.anyTimeVisit, true);
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
      'scheduleModels': [scheduleJson],
      'billingLineModels': [billingJson]
    };

    final job = JobModel.fromJson(json);
    expect(job.objectId, jobObjectId);
    expect(job.ownerId, ownerId);
    expect(job.description, 'Need to fix something important at this job. It’s pretty complex so be prepared for that complexity.');
    expect(job.note, 'note');
    expect(job.jobId, 9253);
    expect(job.jobType, 'Installation');
    expect(job.status, 'Estimate');
  });
}
