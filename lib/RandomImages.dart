import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RandomImages extends StatefulWidget {

  @override
  State<RandomImages> createState() => _RandomImagesState();
}

class _RandomImagesState extends State<RandomImages> {
  var photo="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Images"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (photo=="")?Image.asset("img/img1.png"):Image.network(photo),
            ElevatedButton(
              onPressed: () async{
                Uri url = Uri.parse("https://dog.ceo/api/breeds/image/random");
                var response = await http.get(url);
                if(response.statusCode==200)
                  {
                    var body = response.body.toString();
                    var json = jsonDecode(body);
                    setState(() {
                      photo = json["message"];
                    });
                  }
            },
              child: Text("Get Image"),
            )
          ],
        ),
      ),
    );
  }
}
