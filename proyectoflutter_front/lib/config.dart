const String backendHost = '192.168.1.6'; // IP del servidor backend
const int backendPort = 8000;

String get baseUrl => 'http://$backendHost:$backendPort';
