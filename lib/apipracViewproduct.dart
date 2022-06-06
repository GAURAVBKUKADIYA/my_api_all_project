import 'package:apiproject/apiPracUpdateProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class apipracViewproduct extends StatefulWidget {
  @override
  State<apipracViewproduct> createState() => _apipracViewproductState();
}

class _apipracViewproductState extends State<apipracViewproduct> {
  Future<List> alldata;

  Future<List> viewproduct() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
    } else {
      Fluttertoast.showToast(
          msg: "Chek Your Api Somthing Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      alldata = viewproduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("View Your Product"),
        ),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            if (snapshots.data.length <= 0) {
              return Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshots.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    margin: EdgeInsets.all(15),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Name: " +
                                snapshots.data[index]["pname"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Quantity: " +
                                snapshots.data[index]["qty"].toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "PRICE: " +
                                snapshots.data[index]["price"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("date: " +
                              snapshots.data[index]["added_datetime"]
                                  .toString()),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    AlertDialog alert = AlertDialog(
                                      title: Text(
                                        "Warning",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                      content: Text(
                                          "Are You Sure This Product Is Delete"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {

                                              var pid = snapshots.data[index]["pid"];
                                              Uri url  = Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
                                              var response = await http.post(url,body:{"pid":pid});
                                              if(response.statusCode==200)
                                                {
                                                  var body=response.body.toString();
                                                  var json =jsonDecode(body);
                                                  if(json["status"]=="true")
                                                    {
                                                      Navigator.of(context).pop();
                                                      setState(() {
                                                        alldata=viewproduct();
                                                      });
                                                    }
                                                }


                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: Text("Yes")),
                                        ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No")),
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  child: Text("Delete")),
                              SizedBox(
                                width: 80,
                              ),
                              ElevatedButton(
                                  onPressed: ()async {

                                    var pid = snapshots.data[index]["pid"];

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>apiPracUpdateProduct(updateid: pid,)));
                                  }, child: Text("Update")),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
