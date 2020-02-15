import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Logo here'),
                ),
                radius: 40.0,
                ),
            ),
            ListTile(
              title: Text('Name'),
              subtitle: Text('Todo App'),
            ),
            ListTile(
              title: Text('More about the app.'),
              subtitle: Text('it tracks your today todos in a fun and expressive manner.'),
            ),
            ListTile(
              title: Text('Maker'),
              subtitle: Text('David kamau'),
            ),
            ListTile(
              title: Text('Follow on github 🧲'),
              subtitle: Text('github.com/kamaathedj.'),
            )
          ],

        )
       ),
      ),
    );
  }
}