import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ListItem {
  int id;
  String name;
  String group;

  ListItem({required this.id, required this.name, required this.group});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List App',
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListItem> items = [
    ListItem(id: 1, name: 'Item 1', group: 'Group A'),
    ListItem(id: 2, name: 'Item 2', group: 'Group B'),
    ListItem(id: 3, name: 'Item 3', group: 'Group A'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List App'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].id.toString()),
            subtitle:
                Text("Name: ${items[index].name} Group: ${items[index].group}"),
            onTap: () {
              _showUpdateDialog(items[index]);
            },
            onLongPress: () {
              _showDeleteDialog(items[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController groupController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Group'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // Add item to the list
                int id = items.length + 1;
                String name = nameController.text;
                String group = groupController.text;

                setState(() {
                  items.add(ListItem(id: id, name: name, group: group));
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(ListItem item) {
    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController groupController =
        TextEditingController(text: item.group);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Group'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                // Update item in the list
                setState(() {
                  item.name = nameController.text;
                  item.group = groupController.text;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(ListItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: Text('Are you sure you want to delete ${item.name}?'),
          actions: [
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteItem(item);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(ListItem item) {
    setState(() {
      items.remove(item);
    });
  }
}
