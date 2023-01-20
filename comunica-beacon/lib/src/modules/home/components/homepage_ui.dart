import 'dart:async';
import 'dart:math';

import 'package:comunica_beacons/src/modules/bluetoothble/services/conectble_service.dart';
import 'package:comunica_beacons/src/modules/bluetoothble/services/scannerble_service.dart';
import 'package:comunica_beacons/src/modules/database/firebase/interface/firebase_interface.dart';
import 'package:comunica_beacons/src/modules/database/firebase/repository/firebase_repository.dart';
import 'package:comunica_beacons/src/modules/gps/services/gps_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../shared/models/beacon_models.dart';
import '../../../shared/models/ble_device_models.dart';

class HomePageUi extends StatelessWidget {
  const HomePageUi({
    Key? key,
    required this.devices,
    required this.plug,
    required this.request,
    required this.gps,
  }) : super(key: key);

  final List<DiscoveredDevice> devices;
  final ConnectorBleService plug;
  final FirebaseInterface request;
  final GpsService gps;

  @override
  Widget build(BuildContext context) {
    double lat = 0;
    double long = 0;
    gps.positionStream.listen((Position? position) {
      if (position != null) {
        lat = position.latitude;
        long = position.longitude;
      }
    });
    return Scaffold(
        /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              Provider.of<ScannerBleService>(context, listen: false).scanner();
            },
            child: const Icon(Icons.search)),*/
        appBar: AppBar(
          title: const Text("beacons comunication"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Card(
                borderOnForeground: true,
                // margin: EdgeInsets.all(20),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //TextField(),
                      Container(
                        width: 300,
                        height: 50,
                        child: TextField(
                            //controller: _controller,
                            decoration: InputDecoration(
                                labelText: "Onde você deseja ir ?",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.green),
                                  borderRadius: BorderRadius.circular(50),
                                ))),
                      ),
                      IconButton(
                          onPressed: () async {
                            await Provider.of<FirebaseRepository>(context,
                                    listen: false)
                                .requisition();
                            print(request.device["latitude"]);
                            Timer.periodic(
                                const Duration(seconds: 5),
                                ((timer) => Provider.of<ScannerBleService>(
                                        context,
                                        listen: false)
                                    .scanner(Uuid.parse(
                                        request.device["serviceUuid"]))));

                            Timer.periodic(const Duration(seconds: 2),
                                ((timer) async {
                              print("lat ${lat}");
                              gps.distanceBetween(
                                  startlat: lat,
                                  startlong: long,
                                  endLat: request.device["latitude"],
                                  endLong: request.device["longitude"]);
                              print(gps.distanceInMeters);
                            }));
                          },
                          icon: const Icon(
                            size: 50,
                            Icons.search,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("locais cadastrados"),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  //request.device.length == 0 ? 0 : request.device.length,
                  itemBuilder: ((context, index) => ListTile(
                        title: const Text("ufes"),
                        subtitle: Text(
                            "${gps.distanceInMeters}"), //Text("${request.device["descricao"]}"),
                      ))),
              const SizedBox(height: 20),
              const Text("Locais perto de você "),
              const SizedBox(height: 20),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: devices.isEmpty ? 0 : devices.length,
                  //request.device.length == 0 ? 0 : request.device.length,
                  itemBuilder: ((context, index) => ListTile(
                        title: Text("${devices[index].name}"),
                        subtitle: Text("${devices[index].id}"),
                      ))),
              ListView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: devices
                    .map(
                      (device) => Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(device.name),
                          subtitle: Text(
                              "${pow(10, ((-69 - device.rssi) / (10 * 2)))}"), //Text(device.id),
                          trailing: ElevatedButton(
                            onPressed: () {
                              plug.connect(device.id);

                              Navigator.of(context).pushNamed("/comunication",
                                  arguments: BleDevice(
                                      name: device.name,
                                      id: device.id,
                                      rssi: device.rssi));
                            },
                            child: const Text("conectar"),
                          ),
                          leading: Column(
                            children: [
                              const Text("rssi"),
                              Text(device.rssi.toString()),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
