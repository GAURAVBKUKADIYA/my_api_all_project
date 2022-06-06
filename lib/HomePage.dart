import 'package:apiproject/AddProductJson.dart';
import 'package:apiproject/ModelViewProduct.dart';
import 'package:apiproject/RandomImages.dart';
import 'package:apiproject/WetherAPiModel.dart';
import 'package:apiproject/WetherApi.dart';
import 'package:apiproject/apipracaddproduct.dart';
import 'package:flutter/material.dart';

import 'AddEmployed.dart';
import 'AddProduct.dart';
import 'ModelViewAnimalApi.dart';
import 'ModelViewEmployed.dart';
import 'ModelViewVechicle.dart';

import 'ViewEmployed.dart';
import 'ViewProduct.dart';
import 'apipracViewproduct.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Api Example"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text("Api"),
              ),
              accountName: Text("Welcome,Api Product Sheet"),
              accountEmail: Text("Welcome Api Employed Sheet"),
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("AddProduct"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AddProduct())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("ViewProduct"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.view_comfortable_outlined),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ViewProduct())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Add Employed"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AddEmployed())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("ViewEmployed"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ViewEmployed())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("ModelViewProduct"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ModelViewProduct())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("ModelViewEmployed"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ModelViewEmployed())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Dog API"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>RandomImages())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Model Animal Api"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ModelViewAnimalApi())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Model Vechicle Api"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ModelViewVechicle())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Add Product Json"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AddProductJson())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Wether Api"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>WetherApi())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text(" model Wether Api"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>WetherAPiModel())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("Api Practice"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>apipracaddproduct())
                );
              },
            ),
            Divider(height: 5,),
            ListTile(
              title: Text("apipracViewproduct"),
              trailing: Icon(Icons.arrow_right_alt),
              leading: Icon(Icons.add_box),

              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>apipracViewproduct())
                );
              },
            ),
          ],

        ),
      ),
      body: Center(
        child: Text("Api"),
      ),
    );
  }
}
