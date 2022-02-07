import "dart:math";
import 'package:intl/intl.dart';

abstract class MockData {
  static final List<String> _fn = [
    'Mark',
    'Jennifer',
    'Mary',
    'Minato',
    'Julia',
    'Spencer',
    'Tyler',
    'Sarah',
    'Levi',
    'Blake',
    'Martin',
    'Lori',
    'Jeff',
    'Diana',
    'Patricia',
    'Susan',
    'Kevin',
    'Adam',
    'Tracy',
    'Jose',
    'Brenda',
    'Charles',
    'Brenda'
  ];

  static final List<String> _ln = [
    'Moller',
    'Davis',
    'Cunningham',
    'Clarkson',
    'Roberts',
    'McVey',
    'Durden',
    'Swope',
    'Clark',
    'Brown',
    'Smith',
    'Williams',
    'Jones',
    'Sanches',
    'Garcia',
    'Miller',
    'Taylor',
    'Moore',
    'Lopez',
    'Thomas',
    'Anderson',
    'Walker',
    'Nguyen'
  ];

  static final List<String> _street = [
    'Jackson St.',
    'Mapble Ave.',
    'Elm Way',
    'Sunset Blvd.',
    '1st',
    '23rd Ave',
    'Harbor Drive',
    'Division Street',
    'Chestnut Way',
    'Meadow Way',
    'Willow St.',
    '82nd Ave',
    'Capitol Highway',
    'North Hampton Way',
    'Ridge Way',
    'Terwilliger Boulevard.',
    'Adams Blvd.',
    'Center St.',
    'Canyon Road',
    'Alberta Street',
    'Cesar Chavez Boulevard',
    'Cornell Road',
    'Naito Parkway'
  ];

  static final List<String> _n1 = [
    'Metke',
    'Progressive',
    'Hometown',
    'Minato',
    'New Trend',
    'Next Level',
    'Sun Valley',
    'Evergreen',
    'Black Forest',
    'Hanson Blake',
    'Dark Horse',
    'Pleasant Hill',
    'Thumbtack',
    'Vortex',
    'Blue Ant',
    'Chula Vista',
    'Nine Marks',
    'Happy Homes',
    'BlueDot',
    'Mark James',
    'Swim Tech',
    'Veritas',
    'Cornerstone'
  ];
  static final List<String> _n2 = [
    'Construction',
    'Cleaning',
    'Construction',
    'Repair',
    'Remodel',
    'Development',
    'Staffing',
    'Environment',
    'Entertainment',
    'Automation',
    'Tech',
    'Creative',
    'Training',
    'Event',
    'Communication',
    'Marketing',
    'Talent',
    'Partners',
  ];
  static final List<String> _n3 = [
    'Collective',
    'Supply',
    'Management',
    'Security',
    'Systems',
    'Seminars',
    'Services',
    'Warehouse',
    'Supplies',
    'Advisors',
    'Consulting',
    'Team',
    'Planning',
    'Design',
    'Platform',
    'Inc.',
  ];
  static final _random = Random();
  static String _getWord(List<String> words) {
    words.shuffle();
    return words[_random.nextInt(words.length)];
  }

  static String fullName() {
    return "${_getWord(_fn)} ${_getWord(_ln)}";
  }

  static String address({city = "Portland", state = "OR"}) {
    return "${_random.nextInt(2000)} ${_getWord(_street)}, $city, $state 9720${_random.nextInt(9)} ";
  }

  static DateTime dateTime() {
    var now = DateTime.now();
    var nextMonth = now.month + 1 < 12 ? now.month + 1 : 1;
    var month = _random.nextBool() ? now.month : nextMonth;
    var day = now.day;
    var newDate = DateTime(now.year, month, (_random.nextInt(25) + day));
    return newDate;
  }

  static String dateString() {
    var myFormat = DateFormat.yMMMd();
    return myFormat.format(dateTime());
  }

  static double price({int max = 900}) {
    return _random.nextInt(max).toDouble() + _random.nextDouble();
  }

  static String priceString({int max = 900, String symbol = '\$'}) {
    return '$symbol ${price(max: max).toStringAsFixed(2)}';
  }

  static String formatPrice(double amt, {String symbol = '\$'}) {
    return '$symbol${amt.toStringAsFixed(2)}';
  }

  static String getOne(List<String> words) {
    return _getWord(words);
  }

  static String companyName() {
    return _random.nextBool()
        ? "${_getWord(_n1)} ${_getWord(_n2)} ${_getWord(_n3)}"
        : "${_getWord(_n1)} ${_getWord(_n3)}";
  }
}
