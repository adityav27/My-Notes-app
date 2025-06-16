import 'package:flutter/material.dart';
import 'package:my_notes_app/pages/components/mytextfield.dart';
import 'package:my_notes_app/pages/welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//getting username and both passwords
final usernameController = TextEditingController();
final pass1Controller = TextEditingController();
final pass2Controller = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
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
            SizedBox(height: 20),
            MyTextField(
              controller: usernameController,
              obsecureText: false,
              hintText: 'Enter your username',
            ),
            SizedBox(height: 10),
            MyTextField(
              controller: pass1Controller,
              hintText: 'Enter your password',
              obsecureText: true,
            ),
            SizedBox(height: 10),
            MyTextField(
              controller: pass2Controller,
              hintText: 'Enter your password again',
              obsecureText: true,
            ),
            SizedBox(height: 10),
            createButton(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/whoa.png', width: 250),
                goToHome(context),
              ],
            ),
          ],
        ),
      ),
    );
    return Scaffold(body: container);
  }

  Padding goToHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0, left: 0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text(
          textAlign: TextAlign.center,
          "Have a account\n"
          "Sign in",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Align toonIMG() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Transform.translate(
        offset: Offset(-50, -10), // move 50px outside to the right
        child: Image.asset('assets/whoa.png', width: 200),
      ),
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
            'or continue with email',
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
      'Sign Up',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  ElevatedButton createButton() {
    return ElevatedButton(
      onPressed: () {},

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        fixedSize: Size(250, 56),
      ),
      child: Text(
        'Create your account',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
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
          'Sign up with Google',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
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
