import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridListView extends StatelessWidget {
  static final String title = 'GridView Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isGrid = true;

  List<String> items = [
    'Process',
    'Design',
    'Engineering',
    'Planning',
    'Strategy',
    'Typography',
    'Interaction',
    'Approach',
    'Direction',
    'Business',
    'Philosophy',
    'Trending',
    'Minimal',
    'Existential',
    'Effect',
    'Progress',
    'Technology',
    'Physics',
    'Science',
    'Common',
    'Practice',
    'Networking',
    'Finance',
    'Consumer',
    'Process',
    'Design',
    'Engineering',
    'Planning',
    'Strategy',
    'Typography',
    'Interaction',
    'Approach',
    'Direction',
    'Business',
    'Philosophy',
    'Trending',
    'Minimal',
    'Existential',
    'Effect',
    'Progress',
    'Technology',
    'Physics',
    'Science',
    'Common',
    'Practice',
    'Networking',
    'Finance',
    'Consumer',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(GridListView.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(4),
          child: buildList(),
        ),
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),
      );

  Widget buildList() => isGrid
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return GridTile(
              child: InkWell(
                child: Ink.image(
                  image: NetworkImage(
                      'https://source.unsplash.com/random?sig=$index'),
                  fit: BoxFit.cover,
                ),
                onTap: () => selectItem(item),
              ),
              footer: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        )
      : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/random?sig=$index',
                ),
              ),
              title: Text(item),
              subtitle: Text('Subtitle $index'),
              onTap: () => selectItem(item),
            );
          },
        );

  void selectItem(String item) {
    final snackBar = SnackBar(
      content: Text(
        'Selected $item...',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
