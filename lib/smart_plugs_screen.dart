import 'package:flutter/material.dart';
 
 class SmartPlugsScreen extends StatefulWidget{
  @override

  _SmartPlugsScreenState createState()=> _SmartPlugsScreenState();
 }

 class _SmartPlugsScreenState extends State<SmartPlugsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Plugs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Smart plugs will go here'),
      )
    );
  }
 }