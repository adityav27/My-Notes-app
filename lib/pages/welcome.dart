import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes_app/pages/loginpage.dart';
import 'package:my_notes_app/pages/register.dart';

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
            welcomeMSG(), // Fixed here (removed Expanded in its definition).
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              fixedSize: Size(284, 59),
            ),
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    color: Color.fromARGB(255, 214, 210, 210),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );
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
      child: Column(
        // Removed Expanded here
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/fire1.png',
              width: 50,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          //welcome msg
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              textAlign: TextAlign.center,
              'W E L C O M E   T O   F I R E   N O T E S',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          //picture 1
          SvgPicture.asset('assets/clouds.svg', width: 430),
        ],
      ),
    );
  }

  BoxDecoration backgroundColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 230, 139, 42),
          Color.fromARGB(255, 163, 11, 11),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
