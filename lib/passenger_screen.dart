// ignore: camel_case_types
import 'package:flutter/material.dart';

class screenview extends StatefulWidget {
  const screenview({Key? key}) : super(key: key);

  @override
  _screenviewState createState() => _screenviewState();
}

// ignore: camel_case_types
class _screenviewState extends State<screenview> {
  get label => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {},
          color: Colors.black,
          iconSize: 35,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
            color: Colors.black,
            iconSize: 35,
          )
        ],
      ),
      body: Container(
        margin:
            EdgeInsets.only(top: 540.0, left: 10.0, right: 10.0, bottom: 10.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(children: [
                Text(
                  "Name",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text("Bus No,", style: TextStyle(fontSize: 20)),
                //make space between texts
                Spacer(),
                Text(DateTime.now().toString()),
              ]),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("absent"),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {},
                    alignment: Alignment.bottomRight,
                    color: Colors.blue,
                    iconSize: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
