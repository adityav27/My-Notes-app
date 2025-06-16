import 'package:flutter/material.dart';
import 'package:my_notes_app/pages/components/mytextfield.dart';
import 'package:my_notes_app/pages/welcome.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

final usernameController = TextEditingController();
final passwordController = TextEditingController();

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
      height: double.infinity,
      //background color
      decoration: backgroundColor(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            title(),
            SizedBox(height: 20),
            googleButton(),
            SizedBox(height: 28),
            dividerBar(),
            SizedBox(height: 40),
            MyTextField(
              controller: usernameController,
              hintText: 'Enter your username',
              obsecureText: false,
            ),
            SizedBox(height: 50),
            MyTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              obsecureText: true,
            ),
            SizedBox(height: 2),
            forgotpass(),
            SizedBox(height: 40),
            goToHome(context),
            SizedBox(height: 1),
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
        child: Image.asset('assets/reflecting.png', width: 500),
      ),
    );
  }

  Padding goToHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 150.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text(
          textAlign: TextAlign.center,
          "Don't have a account\n"
          "sign up",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Row forgotpass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row dividerBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Divider(color: Colors.black, thickness: 2, indent: 10)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'or log in with email',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.black, thickness: 2, endIndent: 10),
        ),
      ],
    );
  }

  Text title() {
    return Text(
      'Log in',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  ElevatedButton googleButton() {
    return ElevatedButton(
      onPressed: () {},

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        fixedSize: Size(306, 56),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/google.png', width: 20),
          SizedBox(width: 10),
          Text(
            'Log in with Google',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

BoxDecoration backgroundColor() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 209, 156, 252),
        Color.fromARGB(255, 113, 61, 156),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
