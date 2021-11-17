import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDataTable extends StatelessWidget {
  CustomerDataTable({Key? key}) : super(key: key);
  final columns = const ['Name', 'Role', 'Level'];
  final customers = generateItems(15);

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
  List<DataRow> getRows(List<Customer> customers) =>
      customers.map((Customer customer) {
        final cells = [customer.name, customer.role, customer.age];
        return DataRow(cells: [
          ...getCells(cells),
        ]);
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: getColumns(columns),
      rows: [...getRows(customers)],
    );
  }
}

List<Customer> generateItems(int numberOfItems) {
  final _random = new Random();
  return List<Customer>.generate(numberOfItems, (int index) {
    return Customer(
        name:
            '${first[_random.nextInt(first.length)]} ${last[_random.nextInt(last.length)]}',
        age: age[_random.nextInt(age.length)],
        role: role[_random.nextInt(role.length)]);
  });
}

class Customer {
  final String name;
  final String role;
  final String age;

  Customer({
    required this.name,
    required this.role,
    required this.age,
  });

  Customer copyWith({
    String? name,
    String? role,
    String? age,
  }) {
    return Customer(
      name: name ?? this.name,
      role: role ?? this.role,
      age: age ?? this.age,
    );
  }
}

const List<String> last = [
  'Abbott',
  'Acosta',
  'Adams',
  'Adkins',
  'Aguilar',
  'Avery',
  'Bailey',
  'Baird',
  'Baker',
  'Baldwin',
  'Ballard',
  'Banks',
  'Benton',
  'Cameron',
  'Campbell',
  'Cantrell',
  'Cardenas',
  'Carey',
  'Castillo',
  'Clark',
  'Clements',
  'Cleveland',
  'Cline',
  'Cobb',
  'Donaldson',
  'Donovan',
  'Dorsey',
  'Dotson',
  'Ellison',
  'Emerson',
  'Erickson',
  'Estrada',
  'Evans',
  'Everett',
  'Farley',
  'Farmer',
  'Farrell',
  'Faulkner',
  'Ford',
  'Foreman',
];
const List<String> first = [
  "Aaran",
  "Jenny",
  "Mary",
  "Mathew",
  "Thomas",
  "Malcom",
  "Martin",
  "Eddy",
  "Tina",
  "Margret",
  "Shelly",
  "Oscar",
  "Ward",
  "Scott",
  "Jacob",
  "Chirs",
  "Martin",
  "Kelly",
  "Nicholas",
  "Steve",
  "Brad",
  "Chuck",
  "Madison",
  "Jared",
  "Matt",
  "PK",
  "JP",
  "Chan",
  "Joel",
  "Stefan"
];
const List<String> role = [
  'Idea Guy',
  'Middle Man',
  'Micro Manager',
  'General Manager',
  'Gun Slinger',
  'Hall Monitor',
  'Adjunct Professor',
  'Reluctant Advisor',
  'Resident Expert',
  'Technical Demigod',
  'Scrum Master',
  'Lead Engineer',
  'Post Modern Designer',
  'Systems Architect',
  'Serial Entreprneur',
  'Jack of all Trades',
  'The Closer',
  'Sale Guy',
  'Huckster in Training',
  'General Contractor',
  'Dev Ops',
  'Special Forces',
  'Tiger Team Lead',
  'Principal Designer',
  'Junior Developer',
  'Mergers and Acquisitions',
  'Rodeo Clown',
  'Yes Man',
  'Intern',
  'Evil Genius',
  'Master Mind',
  'Secret Forces',
  'Custodian',
  'Ambassador',
  'General Council',
  'Board of Directors',
  'Chief Technical Officor',
  'Task Master',
  'Sword Smith',
  'Archer',
  'Pinch Hitter',
  'Cleanup Crew',
  'Key Grip'
];
const List<String> age = [
  'novice',
  'next-level',
  'wizard',
  'ninja',
  'unicorn',
  'apprentice',
  'beginner',
  'old-timer',
  'over the hill',
  'mothballed',
  'crusty',
  'junior',
  'grasshopper',
  'tottler',
  'milenial',
  'sage',
  'scout',
  'layman',
  'rockstar',
  'lumberjack',
  'salty dog'
];
