import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetConnect {


  Future<void> register(String name, String email, String password) async {
    print('---------------------------------i am in register ${email}');
    try {
      final response = await http.post(
        Uri.parse('http://192.168.133.95:8000/api/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Registration successful
        print('Registration successful');
      } else {
        // Registration failed
        print('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }


  Future login(String email, String password) {
    return post(
      'http://192.168.133.95:8000/api/login' as Uri,
    body:   {
        'email': email,
        'password': password,
      },
    );
  }
}

Future<void> logout() async {
  var apiUrl = 'http://192.168.133.95:8000/api/logout';
  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  var httpClient = HttpClient();
  var request = await httpClient.postUrl(Uri.parse(apiUrl));

  headers.forEach((header, value) {
    request.headers.set(header, value);
  });

  var response = await request.close();

  if (response.statusCode == 200) {
    print('Logged out successfully');
  } else {
    print('Failed to logout');
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
}




final Map<String, HighlightedWord> _highlights = {
  'flutter': HighlightedWord(
    onTap: () => print('flutter'),
    textStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  ),
  'voice': HighlightedWord(
    onTap: () => print('voice'),
    textStyle: const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  ),
  'subscribe': HighlightedWord(
    onTap: () => print('subscribe'),
    textStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  ),
  'like': HighlightedWord(
    onTap: () => print('like'),
    textStyle: const TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
    ),
  ),
  'comment': HighlightedWord(
    onTap: () => print('comment'),
    textStyle:  const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  ),
};