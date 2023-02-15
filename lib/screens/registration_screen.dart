

import 'package:flutter/material.dart';
import 'package:flash_chat_flutter_2/components/roundedbutton.dart';
import 'package:flash_chat_flutter_2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:ui';
class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner=false;
  final _auth =FirebaseAuth.instance;
  late  String email;
   late String password;
  final backgroundImage = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/background_image.webp'),
        fit: BoxFit.cover,
      ),
    ),
  );
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body:Stack(

        children:[
          Positioned.fill(child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: backgroundImage,
          )),
        ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          // maxChildSize: 0.8,
          builder:(context,scrollCntroller){
            return SingleChildScrollView(
              controller: scrollCntroller,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email=value;
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password=value;
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your pasword'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                        colour: Colors.blueAccent,
                        title: 'Register',
                        onPressed: () async{
                          // print(email);
                          // print(password);
                          setState(() {
                            showSpinner=true;
                          });
                          try{
                            final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                            if(newUser!=null){
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              showSpinner=false;
                            });
                          }
                          catch(e){
                            print(e);
                          }

                        }),
                  ],
                ),
              ),
            );
          },

        ),
      ),
      ]
    )
    );
  }
}
