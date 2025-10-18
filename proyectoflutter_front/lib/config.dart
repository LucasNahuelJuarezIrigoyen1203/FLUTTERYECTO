// lib/config.dart
const string backendHost = '192.168.1.4'; //cambiar IP correcta
const int backendPort = 8000;

string get baseUrl => 'http://$backendHost:$backendPort';
