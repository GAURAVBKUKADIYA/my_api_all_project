import 'dart:convert';

import 'package:apiproject/models/Wether.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sticky_headers/sticky_headers.dart';

class WetherAPiModel extends StatefulWidget {
  @override
  State<WetherAPiModel> createState() => _WetherAPiModelState();
}

class _WetherAPiModelState extends State<WetherAPiModel> {
  Wether data;

  var lat = 0.0;
  var lon = 0.0;
  LatLng loc;

  getdata(city) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=1694c70d0c42466ba1a52532221005&q=" +
            city +
            "&aqi=no");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        data = Wether.fromJson(json);
        lat = data.location.lat;
        lon = data.location.lon;
        setState(() {
          loc = LatLng(lat, lon);
          _markers.add(
              Marker(markerId: MarkerId('Home'), position: LatLng(lat, lon)));
          if (_controller != null) {
            _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 0,
                target: loc,
                zoom: 14.0,
              ),
            ));
          }
        });
      });
    }
  }

  GoogleMapController _controller;
  Location currentLocation = Location();
  Set<Marker> _markers = {};

  TextEditingController _city = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata("Surat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (data == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: StickyHeader(
                  header: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _city,
                            decoration: InputDecoration(
                                hintText: 'Search',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              var cityname = _city.text.toString();
                              if (cityname.length >= 1) {
                                getdata(cityname);
                              }
                            },
                            icon: Icon(Icons.search))
                      ],
                    ),
                  ),
                  content: Column(
                    children: [
                      SizedBox(height: 10,),
                      Stack(
                        children: [
                          Container(
                            height: 500,
                            decoration: BoxDecoration(
                                border: Border.all(
                                ),
                                image: DecorationImage(
                                  image: AssetImage("img/img3.jpg"),
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.noRepeat,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),

                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(data.location.name.toString().toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.deepPurple,),),
                                    Text(data.location.region.toString().toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                SizedBox(height: 50,),
                                Align(
                                  alignment: Alignment.center,
                                  child:Column(
                                    children: [
                                      Text("TempC  "+data.current.tempC.toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10,),
                                      Text("TempF  "+data.current.tempF.toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                                      Image.network("http://"+data.current.condition.icon.toString().substring(1).substring(1))
                                    ],
                                  ),

                                ),
                                SizedBox(height: 15,),
                                Text(data.location.localtime.toString(),style: TextStyle(fontSize: 20),),
                                SizedBox(height:14,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("lat: "+data.location.lat.toString()),
                                    Text("lon: "+data.location.lon.toString()),
                                  ],
                                ),
                                SizedBox(height: 40,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("WindMph: "+data.current.windMph.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                    Text("WindKph: "+data.current.windKph.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)
                                  ],
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 400,
                        child:GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition:CameraPosition(
                            target: loc,
                            zoom: 14.4746,
                          ),
                          onMapCreated: (GoogleMapController controller){
                            _controller = controller;
                            _controller.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                bearing: 0,
                                target: loc,
                                zoom: 14.0,
                              ),
                            ));
                          },
                          markers: _markers,
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
