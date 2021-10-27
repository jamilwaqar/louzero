import 'package:louzero/controller/enum/models.dart';

extension CTContactTypeEx on CTContactType {
  String get name {
    switch (this) {
      case CTContactType.primary:
        return 'Primary Contact';
      case CTContactType.billing:
        return 'Billing Contact';
      case CTContactType.schedule:
        return 'Scheduling Contact';
    }
  }
}