
import 'package:flutter/material.dart';


import '../services.dart';

import 'Login&SignUp/login_view.dart';
import 'chat_screen.dart';

class HomePage extends StatefulWidget {
  final dynamic userData;
  const HomePage( {super.key, this.userData});

  @override
  State<HomePage> createState() => _HomePageState();

}



class _HomePageState extends State<HomePage> {

  Widget _buildCharacterMenu(String character, String description,) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(

            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 32,
          top: 32,
          bottom: 32,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 50,
              spreadRadius: 5,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome Back , ',),
        actions: [
          IconButton(

            icon: const Icon(Icons.logout_sharp),

            onPressed: ()  {

              //Navigate to login or home screen after logout
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginView()));
            },

          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 32,
                  right: 32,
                ),
                children: [
                  const Text(
                    'Select a Character',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildCharacterMenu(
                    'Product Manager',
                    'As a product manager assistant, I can help you streamline your workflow, prioritize features, and stay organized.',
                  ),
                  const SizedBox(height: 16),
                  _buildCharacterMenu(
                    'Training Coach',
                    'As a training coach assistant, my primary goal is to help you optimize your training program and achieve your fitness goals.',
                  ),
                  const SizedBox(height: 16),
                  _buildCharacterMenu(
                    'Stand Comedian',
                    'As stand-up comedian, my main goal is to help you develop and deliver top-notch comedic performances.',
                  ),
                  const SizedBox(height: 16),
                  _buildCharacterMenu(
                    'Travel Guide',
                    'As a travel guide assistant, my primary goal is to help you create unforgettable travel experiences for you.',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}