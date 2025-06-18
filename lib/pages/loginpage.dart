import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes_app/pages/auth.dart';
import 'package:my_notes_app/pages/components/mybutton.dart';
import 'package:my_notes_app/pages/components/mytextfield.dart';
import 'package:my_notes_app/pages/welcome.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
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

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    try {
      // Show loading spinner
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing by tapping outside
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      debugPrint("Starting sign in process");

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      debugPrint("Login successful for: ${credential.user?.email}");

      // Close the loading spinner
      Navigator.pop(context);

      // Navigate to AuthPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    } on FirebaseAuthException catch (e) {
      // Close the loading spinner
      Navigator.pop(context);

      debugPrint("Login failed with error: $e");
      showErrorMSG(context, e.code);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
      height: double.infinity,
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
              controller: emailController,
              hintText: 'Enter your email address',
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
            Mybutton(onTap: () => signUserIn(context)),
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
    onPressed: () {
      debugPrint('hey');
    },

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
