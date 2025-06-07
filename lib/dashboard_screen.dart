import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  Widget filterButton(String text){
    return ElevatedButton(
      onPressed: (){
        //add filter logic
      },
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Energy Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.grey),
            onPressed: () {
              // Refresh logic
            },
          ),
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 18),

            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: const Text('john.doe@email.com'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(16),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),

      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monitor your energy usage',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                StatCard(title: 'Today', value: '24.5 kWh', change: '+12.0%', changeColor: Colors.green),
                StatCard(title: 'This Week', value: '156.8 kWh', change: '-5.0%', changeColor: Colors.red),
                StatCard(title: 'This Month', value: '642.3 kWh', change: '+8.0%', changeColor: Colors.green),
                StatCard(title: 'Cost', value: '\$89.42', change: '+3.0%', changeColor: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Color changeColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  changeColor == Colors.green ? Icons.trending_up : Icons.trending_down,
                  color: changeColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  change,
                  style: TextStyle(
                    fontSize: 12,
                    color: changeColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
