import 'package:flutter/material.dart';

class DevicesScreen extends StatefulWidget{
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen>{
  String selectedFilter = 'All Devices';
  String selectedSubFilter = 'All';

  final List<Map<String , dynamic>> allDevices = [
    {
      'id' : '00001',
      'name' : 'Living Room Lamp',
      'room' : 'Living Room',
      'power' : '45W',
      'online' : 'true',
      'lastUpdated' : '1 hour ago',
    },
    {
      'id' : '00002',
      'name' : 'Fridge',
      'room' : 'Dining Room',
      'power' : '67W',
      'online' : 'true',
      'lastUpdated' : 'yesterday',
    },
    {
      'id' : '00003',
      'name' : 'Television',
      'room' : 'Guest Hall',
      'power' : '0W',
      'online' : 'False',
      'lastUpdated' : 'Monday',
    },
    {
      'id' : '00057',
      'name' : 'Guest Room Fridge',
      'room' : 'Guest Room',
      'power' : '80W',
      'online' : 'true',
      'lastUpdated' : '15 minutes ago',
    },
    {
      'id' : '00045',
      'name' : 'Bedside socket',
      'room' : 'Maaster Bedroom',
      'power' : '0W',
      'online' : 'false',
      'lastUpdated' : '16 hour ago',
    },
  ];

  List<Map<String, dynamic>> get filteredDevices{
    List<Map<String, dynamic>> devices;
    if(selectedFilter == 'Family'){
      devices = allDevices.where((device) => device['room'] == 'Living Room').toList();
    }
    else if(selectedFilter == 'History'){
       devices = allDevices.where((device) => device['power'] == '0W').toList();
    }
    else {
      devices = List.from(allDevices);
    }

    if (selectedFilter == 'All Devices') {
    switch (selectedSubFilter) {
      case 'On':
        return devices
            .where((device) =>
                device['online'].toString().toLowerCase() == 'true')
            .toList();
      case 'Off':
        return devices
            .where((device) =>
                device['online'].toString().toLowerCase() == 'false')
            .toList();
      case 'Deleted':
        return []; // No deleted devices yet
      default:
        return devices;
    }
  } else {
    return devices;
  }
  }

  void _showAddDeviceDialog(BuildContext context){
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Add New Device'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add a new smart plug to your energy monitoring system'),
            const SizedBox(height: 16),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Device ID',
                hintText: 'e.g., device_001',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Device Name',
                hintText: 'eg: Living Room Lamp',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: roomController,
              decoration: const InputDecoration(
                labelText: 'Room',
                hintText: 'eg: Living Room',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: (){
              Navigator.pop(context);
            }
          ),
          ElevatedButton(
            child: const Text('Add Device'),
            onPressed: (){
              final id = idController.text.trim();
              final name = nameController.text.trim();
              final room = roomController.text.trim();
              if(name.isNotEmpty && room.isNotEmpty){
                setState((){
                  allDevices.add({
                    'id': id,
                    'name' :name,
                    'room':room,
                    'power':'0W',
                    'online': 'false',
                    'lastUpdated' : 'Just now',
                  });
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Devices',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Manage your smart plugs here',
              style: TextStyle(color:Colors.grey, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),

          //Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric (horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: ['All Devices','Family','History'].map((tab){
                  final isSelected =  selectedFilter == tab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedFilter = tab;
                          selectedSubFilter = 'All';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.black : Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height:16),
          //sub filter list
          if(selectedFilter == 'All Devices')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              children: ['All', 'On','Off','Deleted'].map((filter){
                final isActive = selectedSubFilter == filter;
                return ChoiceChip(
                  label: Text(filter),
                  selected: isActive,
                  onSelected: (_){
                    setState(() {
                      selectedSubFilter = filter;
                    });
                  },
                  selectedColor: Colors.blue.shade100,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: isActive ? Colors.black : Colors.grey.shade600,
                  ),
                );
              }).toList(),
            ),
          ),

          //Devices List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredDevices.length,
              itemBuilder: (context, index){
                final device =filteredDevices[index];
                final isOnline = device['online'].toString().toLowerCase() == 'true';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.power, color: isOnline? Colors.green :  Colors.grey, size:28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              device['room'],
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text('Power: ${device['power']}'),
                            Text('Last Update: ${device['lastUpdated']}'),
                          ],
                        ),
                      ),
                      Switch(
                        value: isOnline,
                        onChanged: (_){
                          //add  logic later
                        },
                      ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),

      floatingActionButton: Tooltip(
        message: 'Add Device',
        child: FloatingActionButton(
          onPressed: ()=> _showAddDeviceDialog(context),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}