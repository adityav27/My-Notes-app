import 'package:flutter/material.dart';
import 'package:my_notes_app/pages/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes_app/pages/components/mytextfield.dart';
import 'package:my_notes_app/pages/welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// show error msg
void showErrorMSG(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 75, 72, 72),
        title: Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    },
  );
}

void signUserUp(BuildContext context) async {
  final email = emailController.text.trim();
  final pass1 = pass1Controller.text.trim();
  final pass2 = pass2Controller.text.trim();

  if (pass1 != pass2) {
    // Show password mismatch error
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text("Passwords do not match."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
    return;
  }

  try {
    // Show loading spinner
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    debugPrint("Starting registration process");

    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass1);

    debugPrint("Registration successful for: ${credential.user?.email}");

    // Close the spinner
    Navigator.pop(context);

    // Navigate to AuthPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); // Close the spinner if error occurs

    debugPrint("Registration failed with error: $e");
    showErrorMSG(context, e.code); // Display a readable error
  }
}

//getting username and both passwords
final emailController = TextEditingController();
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
              controller: emailController,
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
      onPressed: () {
        // create user
        signUserUp(context);
      },

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
        Color.fromARGB(255, 230, 139, 42),
        Color.fromARGB(255, 163, 11, 11),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
