import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

import 'Constant/constants.dart';
import 'chat_screen.dart';



class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText speech;
  bool isListening = false;
  String chat='';
  String text = '';
  //////////////////////////////openIa function/////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }
var isloding= false;
  @override
  Widget build(BuildContext context) {
     if(isloding){
       sleep(Duration(seconds: 4));
       return LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF1A1A3F),
        rightDotColor: const Color(0xFFEA3799),
        size: 200,
           
      );
    

    }else {
       return Scaffold(
         appBar: AppBar(
           
           backgroundColor: Colors.blue,
           actions: [IconButton(onPressed: () => Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                 builder: (context) => ChatPage(),)
               ), icon: Icon(Icons.message_outlined)),],
           title: const Text('Speech Recognition'),
         ),
         body:   ListView(
           scrollDirection: Axis.horizontal,
           children: [
             Container(
               child: Column(
                 mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                           Container(
                               margin: EdgeInsets.all(10),
                             color: Colors.cyan,
                             child: Row(

                              mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                               Text(
                                 'You :',
                                 style: const TextStyle(fontSize: 25.0,color: Colors.black),
                               ),
                               Text(text, style: TextStyle(fontSize: 18.0,color: Colors.black38)),
                             ],),

                           ),

                       Container(
                         width: 300,
                         height:  500,
                         margin: EdgeInsets.all(10),

                         child: Column(

                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Text(chat, style: TextStyle(fontSize: 18.0,color: Colors.blueGrey)),
                           ],),

                       ),


                     ],
                   ),
             ),
           ],
         ),


         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: AvatarGlow(
           animate: isListening,
           duration: const Duration(milliseconds: 2000),
           glowColor: Colors.cyan,
           startDelay: const Duration(microseconds: 100),
           child: GestureDetector(
             onTapDown: (details) async {
               try {
                 print('i am hire1');
                 setState(() {
                   isListening = true;

                   print('i am hire2');
                 });
                 var available = await speech.initialize();
                 print('i am hire3${available}');
                 if (available) {
                   setState(() {
                     isListening = true;
                     // Starting speech recognition
                     speech.listen(
                       onResult: (result) {
                         setState(() {
                           text = result.recognizedWords;
                           print('the texte is ${text}'); // Output recognized text to console
                         });
                       },
                     );
                   });
                 } else {
                   // Speech recognition not available on this device
                   print('Speech recognition not available on this device');
                 }
               } catch (e) {
                 // Handling exceptions during speech recognition initialization or listening
                 print('Error during speech recognition: $e');
               }
             },
             onTapUp: (details) {
               speech.stop();
               setState(() {
                 isloding = true;
                 getChatResponse(text);

                 sleep(Duration(seconds: 2));
                 print('i am hire ${text}');
                 isListening = false;
               });

               // Stopping speech recognition
             },
             child: CircleAvatar(
               backgroundColor: Colors.yellow,
               radius: 35,
               child: Icon(
                 isListening ? Icons.mic : Icons.mic_none,
                 color: Colors.white,
               ),
             ),
           ),
         ),
       );
     }
  }

  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );
  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];
  final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');
  Future<void> getChatResponse(String m) async {


    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages:[Messages(role: Role.assistant, content: m)],
      maxToken: 200,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content),
          );
          print("the message is ${element.message!.content}");
          setState(() {
            isloding = false;
            chat = element.message!.content;
          });
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }}

