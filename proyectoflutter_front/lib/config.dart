// lib/config.dart
const String backendHost = '192.168.1.12'; //cambiar IP correcta
const int backendPort = 8000;

String get baseUrl => 'http://$backendHost:$backendPort';
