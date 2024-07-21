import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'models/clipboard_item.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final appDocumentDir = await getApplicationDocumentsDirectory();
//   await Hive.initFlutter(appDocumentDir.path);
//   Hive.registerAdapter(ClipboardItemAdapter());
//   await Hive.openBox<ClipboardItem>('clipboard');
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clipboard Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClipboardManager(),
    );
  }
}

class ClipboardManager extends StatefulWidget {
  @override
  _ClipboardManagerState createState() => _ClipboardManagerState();
}

class _ClipboardManagerState extends State<ClipboardManager> {
  final clipboardBox = Hive.box<ClipboardItem>('clipboard');
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clipboard Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ClipboardSearchDelegate(clipboardBox),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: clipboardBox.listenable(),
        builder: (context, Box<ClipboardItem> box, _) {
          final items = box.values.where((item) => item.content.contains(searchQuery)).toList();
          if (items.isEmpty) {
            return Center(
              child: Text('No items in clipboard history.'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.content),
                subtitle: Text(item.timestamp.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: item.content));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        item.delete();
                      },
                    ),
                    IconButton(
                      icon: Icon(item.isFavorite ? Icons.favorite : Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          item.isFavorite = !item.isFavorite;
                          item.save();
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addClipboardItem,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addClipboardItem() async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null) {
      final newItem = ClipboardItem(
        content: clipboardData.text!,
        timestamp: DateTime.now(),
      );
      clipboardBox.add(newItem);
    }
  }
}

class ClipboardSearchDelegate extends SearchDelegate {
  final Box<ClipboardItem> clipboardBox;

  ClipboardSearchDelegate(this.clipboardBox);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = clipboardBox.values.where((item) => item.content.contains(query)).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          title: Text(item.content),
          subtitle: Text(item.timestamp.toString()),
          trailing: IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: item.content));
              close(context, null);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = clipboardBox.values.where((item) => item.content.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item.content),
          onTap: () {
            query = item.content;
            showResults(context);
          },
        );
      },
    );
  }
}
