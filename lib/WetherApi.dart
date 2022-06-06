import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class WetherApi extends StatefulWidget {

  @override
  State<WetherApi> createState() => _WetherApiState();
}

class _WetherApiState extends State<WetherApi> {


  var cityname="";
  var statename="";
  var countryname="";
  getdata()async{

    Uri url = Uri.parse("http://api.weatherapi.com/v1/current.json?key=1694c70d0c42466ba1a52532221005&q=Surat&aqi=no");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        setState(() {
          cityname = json["location"]["name"];
          statename = json["location"]["region"];
          countryname = json["location"]["country"];
        });
      }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(

                  elevation: 5,
                  color: Colors.red,
                  child: Column(
                    children: [
                Text(cityname+","+statename+" ,"+countryname)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
