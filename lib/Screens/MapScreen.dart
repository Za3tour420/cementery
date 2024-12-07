import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class Client {
  String name;
  String address;
  LatLng location;

  Client(this.name, this.address, this.location);
}

List<Client> clients = [
  Client('Client 1', 'Address 1', LatLng(36.3858089, 9.6746952)),
  Client('Client 2', 'Address 2', LatLng(35.3858089, 9.6746952)),
  Client('Client 3', 'Address 3', LatLng(34.3858089, 9.6746952)),
];

class _MapScreenState extends State<MapScreen> {
  final MapController controller = MapController();
  String dropdownValue1 = 'Option 1';
  String dropdownValue2 = 'Option 1';
  String dropdownValue3 = 'Option 1';
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: dropdownValue1,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: <String>['Option 1', 'Option 2', 'Option 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: dropdownValue2,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: <String>['Option 1', 'Option 2', 'Option 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: dropdownValue3,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue3 = newValue!;
                    });
                  },
                  items: <String>['Option 1', 'Option 2', 'Option 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    child: Row(
                  children: [
                    Checkbox(
                      value: checkboxValue1,
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkboxValue1 = newValue!;
                        });
                      },
                    ),
                    const Text('G')
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Checkbox(
                      value: checkboxValue2,
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkboxValue2 = newValue!;
                        });
                      },
                    ),
                    const Text('D')
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Checkbox(
                      value: checkboxValue3,
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkboxValue3 = newValue!;
                        });
                      },
                    ),
                    const Text('NC')
                  ],
                )),
              ],
            ),
          ),
          Expanded(
              child: FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: LatLng(36.3858089, 9.6746952),
              initialZoom: 7,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  for (var client in clients)
                    Marker(
                        point: client.location,
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Text(client.name),
                                Text(client.address),
                              ],
                            )
                        
                            
                          ],
                        ))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
