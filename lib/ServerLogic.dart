import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum() {
  return http.get('http://localhost:5000/api/trainid?id=15');
}