import 'package:flutter/material.dart';

class ListViewRef extends StatefulWidget {
  final String title;

  const ListViewRef({
    required this.title,
  });

  @override
  _ListViewRefState createState() => _ListViewRefState();
}

class _ListViewRefState extends State<ListViewRef> {
  int index = 0;
  final items = List.generate(2000, (counter) => 'Item: $counter');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildListViews(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Text('ListView'),
              label: 'Basic',
            ),
            BottomNavigationBarItem(
              icon: Text('ListView'),
              label: 'Vertical',
            ),
            BottomNavigationBarItem(
              icon: Text('ListView'),
              label: 'Horizontal',
            ),
          ],
          onTap: (int index) => setState(() => this.index = index),
        ),
      );

  Widget buildListViews() {
    if (index == 0) {
      return buildBasicListView();
    } else if (index == 1) {
      return buildVerticalListView();
    } else if (index == 2) {
      return buildHorizontalListView();
    } else {
      return Container();
    }
  }

  Widget buildBasicListView() => ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text('Favourites'),
            subtitle: Text('All your favourite widgets'),
            trailing: Icon(Icons.star, color: Colors.orange),
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text('High Ranked'),
            subtitle: Text('All widgets liked by the community'),
            trailing: Icon(Icons.mood, color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text('Important'),
            subtitle: Text('All widgets that are important to know'),
            trailing: Icon(Icons.assistant_photo, color: Colors.black),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text('Deleted'),
          ),
        ],
      );

  Widget buildVerticalListView() => ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(color: Colors.black),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item),
          );
        },
      );

  Widget buildHorizontalListView() => Container(
        height: 100,
        child: ListView.separated(
          padding: EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => Divider(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 16),
              child: Text(item, style: const TextStyle(fontSize: 24)),
            );
          },
        ),
      );
}
