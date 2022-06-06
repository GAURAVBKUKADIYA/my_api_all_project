import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewEmployed extends StatefulWidget {


  @override
  State<ViewEmployed> createState() => _ViewEmployedState();
}

class _ViewEmployedState extends State<ViewEmployed> {

  Future<List> alldata;

  Future<List> getemployed()async{
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
       return json["data"];
      }
    else
      {
        Fluttertoast.showToast(
            msg:"Api Eror" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getemployed();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("ViewEmployed"),
        ),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshots){
          if(snapshots.hasData)
            {
              if(snapshots.data.length<=0)
                {
                  return Center(child: Text("No Data Found"),);
                }
              else
                {
                  return ListView.builder(
                    itemCount: snapshots.data.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100
                        ),
                        width: 200,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nmae: "+snapshots.data[index]["ename"].toString(),style:(TextStyle(fontSize: 20)),),
                            Text(snapshots.data[index]["salary"].toString()),
                            Text(snapshots.data[index]["department"].toString()),
                            Text(snapshots.data[index]["gender"].toString()),

                                Text(snapshots.data[index]["added_datetime"].toString()),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: ()async{
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Are You Sure",style: TextStyle(color: Colors.red),),
                                      content: Text("This Employed Data has Delete"),
                                      actions: [
                                      ElevatedButton(
                                        onPressed: ()async{
                                          var eid = snapshots.data[index]['eid'];
                                          Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteEmployeeNormal.php");
                                          var response = await http.post(url,body: {"eid":eid});
                                          if(response.statusCode==200)
                                          {
                                            var body = response.body.toString();
                                            var json = jsonDecode(body);
                                            if(json["status"]=="true")
                                              {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  alldata = getemployed();
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

                                          child: Text("No"),
                                        ),

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
                                      textStyle:
                                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  child: Text("Delete"),
                                ),
                                SizedBox(width: 20,),
                                ElevatedButton(
                                  onPressed: ()async{},

                                  child: Text("Update"),
                                ),
                              ],
                            )



                          ],
                        ),
                      );
                    },
                  );
                }
            }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
