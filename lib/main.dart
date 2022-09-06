import 'package:flutter/material.dart';
import 'package:todo/supabase_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SupaBaseHandler supaBaseHandler = SupaBaseHandler();

  @override
  Widget build(BuildContext context) {
    String newValue = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.none) {}
          return ListView.builder(
              itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: snapshot.data[index]['status']
                      ? Colors.white
                      : Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      SizedBox(
                        width: 200,
                        child: Text(snapshot.data[index]['task']),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 50)),
                      IconButton(
                          icon: const Icon(Icons.done),
                          onPressed: () {
                            supaBaseHandler.updateData(
                                snapshot.data[index]['id'], true);
                            setState(() {});
                          }),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            supaBaseHandler
                                .deleteData(snapshot.data[index]['id']);
                            setState(() {});
                          }),
                    ],
                  ),
                );
              });
        },
        future: supaBaseHandler.readData(),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(onChanged: (value) {
                newValue = value;
              }),
            ),
            FloatingActionButton(
              onPressed: () {
                supaBaseHandler.addData(newValue, false);
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
            const Padding(padding: EdgeInsets.only(left: 10, bottom: 10)),
            FloatingActionButton(
              onPressed: () {
                setState(() {});
              },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
