import 'dart:convert';

import 'package:apiproject/resources/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  var output="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: SingleChildScrollView(
       child: Container(
         margin: EdgeInsets.all(10),
         padding: EdgeInsets.all(10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("ProductName",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             SizedBox(height: 10,),
             TextField(
               controller: _name,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0),
                 ),),
               keyboardType: TextInputType.text,
             ),
             SizedBox(height: 10,),
             Text("Quantity",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             SizedBox(height: 10,),
             TextField(
               controller: _qty,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0),
                 ),),
               keyboardType: TextInputType.number,
             ),
             SizedBox(height: 10,),
             Text("Price",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             SizedBox(height: 10,),
             TextField(
               controller: _price,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0),
                 ),),
               keyboardType: TextInputType.number,
             ),
             SizedBox(height: 20,),
             Center(
               child: ElevatedButton(
                 onPressed: ()async{
                   var name = _name.text.toString();
                   var qty = _qty.text.toString();
                   var price = _price.text.toString();

                   Map<String,String> params = {
                     "pname":name,
                     "qty":qty,
                     "price":price
                   };


                   Uri url = Uri.parse(UrlHelper.ADD_PRODUCT_NORMAL);
                   var response = await http.post(url,body: params);

                   if(response.statusCode==200)
                     {
                       var body = response.body.toString();
                       var json = jsonDecode(body);
                       if(json["status"]=="true")
                         {
                           var message = json["message"].toString();
                           final snackBar = SnackBar(
                             content: Text(message),
                             backgroundColor: (Colors.green),
                             action: SnackBarAction(
                               label: 'dismiss',
                               onPressed: () {
                               },
                             ),
                           );
                           ScaffoldMessenger.of(context).showSnackBar(snackBar);

                           // thank you
                         }
                       else
                         {
                           var message = json["message"].toString();
                           print(message);
                           //error
                         }
                     }
                   else
                     {
                       print("API Error");
                     }



                   
                   // Uri url = Uri.parse("http://192.168.29.63/api/addproduct.php");
                   // var response = await http.post(url,body: {
                   //   "name":name,
                   //   "qty":qty,
                   //   "price":price
                   // });
                   //
                   // if(response.statusCode==200)
                   //   {
                   //     var body = response.body.toString();
                   //     print("Response :: "+body);
                   //   }
                   // else
                   //   {
                   //     print("API Error");
                   //   }


                 },


                 child: Text("Add"),
               ),
             )
           ],
         ),
       ),
      ),
      // body: Column(
      //   children: [
      //     Text(output),
      //     ElevatedButton(
      //       onPressed: () async
      //       {
      //         // Uri uri = Uri.parse("http://192.168.29.63/api/getrequest.php");
      //         // var response = await http.post(uri);
      //         // if(response.statusCode==200)
      //         // {
      //         //   var body = response.body.toString();
      //         //   setState(() {
      //         //     output=body;
      //         //   });
      //         // }
      //         // else
      //         // {
      //         //   print("API Error");
      //         // }
      //
      //         //200 ok
      //         //400 not found
      //         //500 Server
      //
      //
      //       },
      //       child: Text("Call API"),
      //     )
      //   ],
      // ),
    );
  }
}
