import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlkimiaTech',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MedicalDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BluetoothService {
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;
  BluetoothService._internal();

  List<Map<String, dynamic>> devices = [];
  bool isScanning = false;
  bool isConnected = false;
  Timer? _simulationTimer;

  Function(List<Map<String, dynamic>>)? onDevicesUpdated;
  Function(bool)? onConnectionChanged;
  Function(int, int)? onHealthDataReceived;

  void startScan() {
    devices.clear();
    isScanning = true;

    Future.delayed(Duration(seconds: 2), () {
      devices = [
        {'name': 'Amazfit Bip 6', 'deviceId': 'simulated_1'},
        {'name': 'Apple Watch', 'deviceId': 'simulated_2'},
      ];
      isScanning = false;
      onDevicesUpdated?.call(devices);
    });
  }

  void stopScan() {
    isScanning = false;
  }

  Future<bool> connectToDevice(Map<String, dynamic> device) async {
    await Future.delayed(Duration(seconds: 1));
    isConnected = true;
    onConnectionChanged?.call(true);

    _simulationTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (!isConnected) {
        timer.cancel();
        return;
      }
      int hr = 60 + (DateTime.now().second % 50);
      int spo2 = 95 + (DateTime.now().second % 5);
      onHealthDataReceived?.call(hr, spo2);
    });
    return true;
  }

  Future<void> disconnect() async {
    _simulationTimer?.cancel();
    isConnected = false;
    onConnectionChanged?.call(false);
  }

  void dispose() {
    _simulationTimer?.cancel();
    disconnect();
  }
}

class MedicalDashboard extends StatefulWidget {
  @override
  _MedicalDashboardState createState() => _MedicalDashboardState();
}

class _MedicalDashboardState extends State<MedicalDashboard> {
  final BluetoothService _bluetoothService = BluetoothService();

  int _heartRate = 0;
  int _oxygenLevel = 0;
  bool _isConnected = false;
  bool _isScanning = false;
  List<Map<String, dynamic>> _devices = [];

  @override
  void initState() {
    super.initState();
    _bluetoothService.onConnectionChanged = (connected) {
      setState(() => _isConnected = connected);
    };
    _bluetoothService.onHealthDataReceived = (hr, spo2) {
      setState(() {
        if (hr > 0) _heartRate = hr;
        if (spo2 > 0) _oxygenLevel = spo2;
      });
    };
    _bluetoothService.onDevicesUpdated = (devices) {
      setState(() => _devices = devices);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AlkimiaTech',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isConnected ? Colors.green[100] : Colors.red[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isConnected
                        ? Icons.bluetooth_connected
                        : Icons.bluetooth_disabled,
                    color: _isConnected ? Colors.green : Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text(
                    _isConnected ? 'CONECTADO' : 'DESCONECTADO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '❤️ HEART RATE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$_heartRate',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text('bpm'),
                  ],
                ),
              ),
            ),

            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '💨 OXYGEN LEVEL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$_oxygenLevel',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text('%'),
                  ],
                ),
              ),
            ),

            Card(
              elevation: 4,
              color: Colors.deepPurple[50],
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '⚠️ CRISIS RISK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _heartRate > 100 ||
                              (_oxygenLevel < 90 && _oxygenLevel > 0)
                          ? 'ALTO'
                          : 'NORMAL',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color:
                            _heartRate > 100 ||
                                (_oxygenLevel < 90 && _oxygenLevel > 0)
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            if (!_isConnected)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _isScanning
                        ? null
                        : () {
                            setState(() => _isScanning = true);
                            _bluetoothService.startScan();
                          },
                    child: Text(_isScanning ? 'BUSCANDO...' : 'BUSCAR RELOJ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                  ),
                  if (_isScanning) SizedBox(height: 10),
                  if (_isScanning) CircularProgressIndicator(),
                  if (_devices.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: _devices
                            .map(
                              (device) => Card(
                                child: ListTile(
                                  leading: Icon(Icons.watch),
                                  title: Text(device['name']),
                                  onTap: () async {
                                    setState(() => _isScanning = false);
                                    _bluetoothService.stopScan();
                                    await _bluetoothService.connectToDevice(
                                      device,
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ],
              ),

            if (_isConnected)
              ElevatedButton(
                onPressed: () => _bluetoothService.disconnect(),
                child: Text('DESCONECTAR'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bluetoothService.dispose();
    super.dispose();
  }
}
