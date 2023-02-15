import 'package:flash_chat_flutter_2/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter_2/components/roundedbutton.dart';
import 'package:flash_chat_flutter_2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner=false;
  final _auth = FirebaseAuth.instance;
  late String email;
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
        backgroundColor: Colors.white,
        body: Stack(
          children:[
            Positioned.fill(child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: backgroundImage,
            )),
          ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          builder: (context, scrollCntroller) {
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
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email',

                      ),
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
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your pasword',
                        )),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                        colour: Colors.lightBlueAccent,
                        title: 'Log In',
                        onPressed: () async {
                          setState(() {
                            showSpinner=true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              showSpinner=false;
                            });
                          } catch (e) {
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



