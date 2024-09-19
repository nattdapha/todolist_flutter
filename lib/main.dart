import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 30, 125, 233)),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({
    super.key,
  });

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _controller;
  late TextEditingController _detailsController;
  final List<Map<String, String>> _myList = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _detailsController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Task Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _detailsController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Task Details"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _myList.add({
                        'title': _controller.text,
                        'details': _detailsController.text,
                      });
                    });
                    _controller.clear();
                    _detailsController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: _myList.length,
        itemBuilder: (context, index) {
          final item = _myList[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
              ),
            ),
            child: ListTile(
              title: Text(
                item['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item['details']!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
