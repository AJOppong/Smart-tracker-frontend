import 'package:flutter/material.dart';
import 'main_navigation.dart';

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

    final List<Map<String, dynamic>> devices = [
      {
        'name': 'Living Room Plug',
        'status': 'ON',
        'icon': Icons.power,
        'statusColor': Colors.green,
      },
      {
        'name': 'Kitchen Plug',
        'status': 'OFF',
        'icon': Icons.power_off,
        'statusColor': Colors.red,
      },
      {
        'name': 'Bedroom Socket',
        'status': '3.2 kWh',
        'icon': Icons.electrical_services,
        'statusColor': Colors.blue,
      },
    ];

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
            const SizedBox(height: 24),
            const Text(
              'Real-Time Usage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.speed, size: 40, color: Colors.blue),
                  SizedBox(height: 12),
                  Text(
                    'Current Usage',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '3.42 kWh',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
              const Text(
                'Connected Devices',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // List of devices
              ListView.builder(
                itemCount: devices.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DeviceCard(
                      name: device['name'],
                      status: device['status'],
                      icon: device['icon'],
                      statusColor: device['statusColor'],
                    ),
                  );
                },
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

class DeviceCard extends StatelessWidget{
  final String name;
  final String status;
  final IconData icon;
  final Color statusColor;

  const DeviceCard({
    super.key,
    required this.name,
    required this.status,
    required this.icon,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0,2),
        ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}