import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, String>> lists = [];

  void _addList() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        String id = '';
        String name = '';
        String group = '';
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'ID'),
                onChanged: (value) => id = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Group'),
                onChanged: (value) => group = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    lists.add({'id': id, 'name': name, 'group': group});
                  });
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateList(int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        String id = lists[index]['id']!;
        String name = lists[index]['name']!;
        String group = lists[index]['group']!;
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'ID'),
                controller: TextEditingController(text: id),
                onChanged: (value) => id = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: TextEditingController(text: name),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Group'),
                controller: TextEditingController(text: group),
                onChanged: (value) => group = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    lists[index] = {'id': id, 'name': name, 'group': group};
                  });
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete List'),
          content: Text('Are you sure you want to delete this list?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  lists.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (BuildContext context, int index) {
          
          return ListTile(
            title: Text(lists[index]['name']!),
            subtitle: Text(
                'ID: ${lists[index]['id']} | Group: ${lists[index]['group']}'),
            onTap: () {
              _updateList(index);
            },
            onLongPress: () {
              _deleteList(index);
            },
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addList();
        },
        tooltip: 'Add List',
        child: Icon(Icons.add),
      ),
    );
  }
}
