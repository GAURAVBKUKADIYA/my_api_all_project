import 'dart:convert';

import 'package:apiproject/UpdateYourProduct.dart';
import 'package:apiproject/resources/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewProduct extends StatefulWidget {
  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  Future<List> alldata;

  Future<List> getproduct() async {
    Uri url = Uri.parse(UrlHelper.VIEW_PRODUCT);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
    } else {
      print("API Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getproduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("View Product"),
        ),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            if (snapshots.data.length <= 0) {
              return Center(
                child: Text("No data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshots.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue.shade50,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshots.data[index]["pname"].toString()),
                        Text(snapshots.data[index]["qty"].toString()),
                        Text(
                          "Rs." + snapshots.data[index]["price"].toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                AlertDialog alert = AlertDialog(
                                  title: Text("Are You Sure",style: TextStyle(color: Colors.red),),
                                  content: Text("This Product Data Has Delete"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: ()async{
                                        var pid  = snapshots.data[index]['pid'];
                                        Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
                                        var response = await http.post(url,body: {'pid':pid});
                                        if(response.statusCode==200)
                                          {
                                            var body = response.body.toString();
                                            var json = jsonDecode(body);
                                            if(json["status"]=="true")
                                              {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  alldata = getproduct();
                                                });
                                              }
                                          }
                                      },

                                      child: Text("Yes"),
                                    ),
                                    ElevatedButton(
                                        onPressed: ()async{
                                          Navigator.of(context).pop();
                                        },

                                        child:Text("No"))
                                  ],
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red.shade800,
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              child: Text("Delete"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  var pid  = snapshots.data[index]['pid'];
                                 Navigator.of(context).push(
                                 MaterialPageRoute(builder: (context)=>UpdateYourProduct(updatepid:pid.toString()))
                                 );
                                },

                                child: Text("Update")),
                          ],
                        ),
                        Divider(
                          height: 5,
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
