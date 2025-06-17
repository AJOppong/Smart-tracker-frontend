import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget{
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
  with SingleTickerProviderStateMixin{
    late TabController _tabController;

    @override
    void initState(){
      super.initState();
      _tabController = TabController(length: 3, vsync: this);
    }

    @override
    void dispose(){
      _tabController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(

      );
    }
  }