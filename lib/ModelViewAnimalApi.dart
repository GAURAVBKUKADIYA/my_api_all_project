import 'dart:convert';

import 'package:apiproject/models/Animal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'AnimalFullInformation.dart';

class ModelViewAnimalApi extends StatefulWidget {


  @override
  State<ModelViewAnimalApi> createState() => _ModelViewAnimalApiState();
}

class _ModelViewAnimalApiState extends State<ModelViewAnimalApi> {
    List<Animal> data;

  getanimal()async
  {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);

        setState(() {
          data = json.map<Animal>
            ((obj) => Animal.fromJson(obj)
          ).toList();
        });

      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getanimal();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(data!=null)?SafeArea(
        child: GridView.builder(
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0
          ),
          itemCount:data.length,
          itemBuilder: (context,index){
            return Container(
              height: 500.0,
              margin: EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: ()async{
                Navigator.of(context).push(
               MaterialPageRoute(builder: (context)=>AnimalFullInformation(obj: data[index])
                ));
              },


              child: Card(
                elevation: 5.0,
                child: Column(
                  children: [
                    Expanded(
                    child:   Container(

                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage((data[index].imageLink.toString())),
                        fit:BoxFit.cover
                    ),
                  ),child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),


              )),
                //child: Image.network()
                ),

                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [

                          Text(data[index].name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data[index].latinName.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            );
          },
        )
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("Please Wait")
          ],
        )
      )
    );
  }
}
