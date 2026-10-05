import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;
  BluetoothService._internal();

  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? connectedDevice;
  bool isScanning = false;
  bool isConnected = false;
  StreamSubscription? _scanSubscription;
  Timer? _simulationTimer;

  Function(List<BluetoothDevice>)? onDevicesUpdated;
  Function(bool)? onConnectionChanged;
  Function(int, int)? onHealthDataReceived;

  // UUIDs para Amazfit Bip 6
  static const String HR_UUID = "00002a37-0000-1000-8000-00805f9b34fb";
  static const String SPO2_UUID = "00002a5f-0000-1000-8000-00805f9b34fb";
  static const String HEALTH_SERVICE = "0000180d-0000-1000-8000-00805f9b34fb";

  void startScan() {
    devices.clear();
    isScanning = true;
    _scanSubscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devices.contains(result.device)) {
          devices.add(result.device);
        }
      }
      onDevicesUpdated?.call(devices);
    });
    flutterBlue.startScan(timeout: Duration(seconds: 10));
  }

  void stopScan() {
    flutterBlue.stopScan();
    isScanning = false;
    _scanSubscription?.cancel();
  }

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(timeout: Duration(seconds: 15));
      connectedDevice = device;
      isConnected = true;
      onConnectionChanged?.call(true);
      print("✅ Conectado a: ${device.name}");

      await _subscribeToServices(device);
      return true;
    } catch (e) {
      print("❌ Error de conexión: $e");
      _useSimulationFallback();
      return false;
    }
  }

  Future<void> _subscribeToServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          // Heart Rate
          if (characteristic.uuid.toString().toUpperCase().contains("2A37")) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              int hr = _parseHeartRate(value);
              print("❤️ HR REAL: $hr bpm");
              onHealthDataReceived?.call(hr, -1);
            });
          }
          // SpO2
          if (characteristic.uuid.toString().toUpperCase().contains("2A5F")) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              int spo2 = _parseSpO2(value);
              print("💨 SpO2 REAL: $spo2%");
              onHealthDataReceived?.call(-1, spo2);
            });
          }
        }
      }
    } catch (e) {
      print("⚠️ No se encontraron servicios de salud: $e");
      _useSimulationFallback();
    }
  }

  int _parseHeartRate(List<int> value) {
    if (value.isEmpty) return 0;
    int flags = value[0];
    int hrFormat = flags & 0x01;
    if (hrFormat == 0) return value[1];
    return (value[2] << 8) | value[1];
  }

  int _parseSpO2(List<int> value) {
    if (value.length > 1) return value[1];
    return 0;
  }

  void _useSimulationFallback() {
    print("🔄 Usando datos simulados (fallback)");
    _simulationTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (!isConnected) {
        timer.cancel();
        return;
      }
      int hr = 60 + (DateTime.now().second % 50);
      int spo2 = 95 + (DateTime.now().second % 5);
      onHealthDataReceived?.call(hr, spo2);
    });
  }

  Future<void> disconnect() async {
    _simulationTimer?.cancel();
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      connectedDevice = null;
    }
    isConnected = false;
    onConnectionChanged?.call(false);
  }

  void dispose() {
    _simulationTimer?.cancel();
    _scanSubscription?.cancel();
    stopScan();
    disconnect();
  }
}
