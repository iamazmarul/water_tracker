import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/function/functions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _numberOfGlassTEC = TextEditingController(text: "1");
  List<WaterTracker> waterCountList = [];
  int totalWater = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Tracker"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Total Consume",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$totalWater",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _numberOfGlassTEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int amount = int.tryParse(_numberOfGlassTEC.text.trim()) ?? 1;
                  totalWater += amount;
                  WaterTracker waterTrack =
                      WaterTracker(time: DateTime.now(), noOfGlass: amount);
                  waterCountList.add(waterTrack);
                  setState(() {});
                  _numberOfGlassTEC.text ="1";
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  backgroundColor: Colors.indigo,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: waterCountList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xFFF3E5F5),
                  child: ListTile(
                    onLongPress: () {
                      setState(() {
                        int removeCount = waterCountList[index].noOfGlass;
                        waterCountList.removeAt(index);
                        totalWater -= removeCount;
                      });
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo[400],
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      DateFormat('HH:mm:ss a dd-MM-yyyy')
                          .format(waterCountList[index].time),
                      style: TextStyle(color: Colors.indigo[900]),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${waterCountList[index].noOfGlass}",
                          style: TextStyle(
                              fontSize: 20, color: Colors.indigo[900]),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              int removeCount = waterCountList[index].noOfGlass;
                              waterCountList.removeAt(index);
                              totalWater -= removeCount;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
