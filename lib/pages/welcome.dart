import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
      //background color
      decoration: backgroundColor(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            welcomeMSG(),
            SizedBox(height: 30),
            signButton(),
            toonIMG(),
          ],
        ),
      ),
    );
    return Scaffold(body: container);
  }

  Align toonIMG() {
    return Align(
      alignment: Alignment.centerRight,
      child: Transform.translate(
        offset: Offset(80, -50), // move 50px outside to the right
        child: Image.asset('assets/wlcmGirl.png', width: 500),
      ),
    );
  }

  Center signButton() {
    return Center(
      child: Column(
        children: [
          //SIGN up Button
          Container(
            width: 284,
            height: 59,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: const Color.fromARGB(255, 79, 73, 73),
                  blurRadius: 4,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            //already have acc
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Text(
                  'Already have an account',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 214, 210, 210),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              //Login button
              TextButton(
                onPressed: () {
                  //go to sign in page
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding welcomeMSG() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.favorite, size: 50),
            ),
            SizedBox(height: 10),
            //welcome msg
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Welcome!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            //picture 1
            SvgPicture.asset('assets/clouds.svg', width: 430),
          ],
        ),
      ),
    );
  }

  BoxDecoration backgroundColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 218, 172, 255),
          Color.fromARGB(255, 133, 83, 174),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
