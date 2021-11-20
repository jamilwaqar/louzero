import 'package:flutter/material.dart';

class SortList extends StatelessWidget {
  static const String title = 'Sort ListView';

  const SortList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainPage(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isDescending = false;

  List<String> items = [
    'Murphy',
    'Oliver',
    'Sophia',
    'Yasmin',
    'Zahara',
    'Anna',
    'Brandon',
    'Emma',
    'Lucas',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(SortList.title),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextButton.icon(
              icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.compare_arrows, size: 28),
              ),
              label: Text(
                isDescending ? 'Descending' : 'Ascending',
                style: const TextStyle(fontSize: 16),
              ),
              onPressed: () => setState(() => isDescending = !isDescending),
            ),
            Expanded(child: buildList()),
          ],
        ),
      );

  Widget buildList() => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final sortedItems = items
            ..sort((item1, item2) =>
                isDescending ? item2.compareTo(item1) : item1.compareTo(item2));
          final item = sortedItems[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/random?sig=$index',
              ),
            ),
            title: Text(item),
            subtitle: Text('Subtitle $index'),
            onTap: () {},
          );
        },
      );
}
