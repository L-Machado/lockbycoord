import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapCoordinateScreen extends StatefulWidget {
  @override
  _MapCoordinateScreenState createState() => _MapCoordinateScreenState();
}

class _MapCoordinateScreenState extends State<MapCoordinateScreen> {
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  LatLng? _location;

  void _updateLocation() {
    try {
      double latitude = double.parse(_latitudeController.text);
      double longitude = double.parse(_longitudeController.text);

      setState(() {
        _location = LatLng(latitude, longitude);
      });
    } catch (e) {
      // Se ocorrer um erro, define Araraquara como fallback
      setState(() {
        _location = LatLng(-21.7948, -48.1756); // Coordenadas de Araraquara
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Coordenadas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _latitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _longitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateLocation,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: _location != null
                  ? FlutterMap(
                      options: MapOptions(
                        center: _location,
                        zoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: _location!,
                              builder: (ctx) => Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: Text('Insira as coordenadas para ver o local')),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapCoordinateScreen(),
  ));
}
