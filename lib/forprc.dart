import 'package:flutter/material.dart';

class forprc extends StatefulWidget {


  @override
  State<forprc> createState() => _forprcState();
}

class _forprcState extends State<forprc> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: change_color == true ? Colors.green : Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: new Text('Change Color'),
              textColor: Colors.white,
              // 2

              // 3
              onPressed: () => {
                setState(() {
                  change_color = !change_color;
                })
              },
            )
          ],
        ),
      ),
    );
  }

  bool change_color = false;
}
