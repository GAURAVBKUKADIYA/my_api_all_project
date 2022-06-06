import 'package:apiproject/models/Animal.dart';
import 'package:flutter/material.dart';

class AnimalFullInformation extends StatefulWidget {

  Animal obj;

  AnimalFullInformation({this.obj});
  @override
  State<AnimalFullInformation> createState() => _AnimalFullInformationState();
}

class _AnimalFullInformationState extends State<AnimalFullInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
      child: SingleChildScrollView(
          child:Container(
            child: Column(
              children: [

                Stack(
                  children: [

                    Container(
                        margin: EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height/1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(widget.obj.imageLink),
                              fit:BoxFit.fill
                          ),
                        ),child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      shadowColor: Colors.grey,

                    )),
                    IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back,size: 50,),
                    ),

                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(

                        children: [
                          Text("Name:-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(width: 42,),
                          Text(widget.obj.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("LatinName:-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          SizedBox(width: 15,),
                          Text(widget.obj.latinName),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("ActiveTime:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 15,),
                          Text(widget.obj.activeTime),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("AnimalType:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,),
                          Text(widget.obj.animalType),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),

                      Row(
                        
                        children: [
                          Text("Diet:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 80,),
                         Expanded(child:  Text(widget.obj.diet),)
                        ],
                      ),

                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("lengthMin:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 22,),
                          Text(widget.obj.lengthMin),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("lengthMax:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 21,),
                          Text(widget.obj.lengthMax),
                        ],
                      ),
                      Divider(height: 5, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("LifeSpan:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 35,),
                          Text(widget.obj.lifespan),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("Habitat:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 45,),
                          Text(widget.obj.habitat),
                        ],
                      ),
                      Divider(height: 7, thickness: 3,color: Colors.blue.shade200,),
                      Row(
                        children: [
                          Text("GeoPange:-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(width: 18,),
                      Expanded(child:     Text(widget.obj.geoRange),)
                        ],
                      ),
                    ],
                  ),
                ),





              ],
            ),
          )
      ),
     ),
    );
  }
}
