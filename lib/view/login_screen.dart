import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/controller/registration_and_login_controller.dart';
import 'package:flutter_application_4/view/home_screen.dart';
import 'package:flutter_application_4/view/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  RegistraionAndLoginController dbController = RegistraionAndLoginController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    } else if (!dbController.mydb.keys.contains(value)) {
                      return "Username does not exist";
                    } else {
                      return null;
                    }
                  },
                  controller: userNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "User name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "password must be 6 characters or more";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          togglePassword();
                        },
                        icon: obscurePassword
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined)),
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          final password = dbController.mydb
                              .get(userNameController.text)
                              ?.password;
                          if (formKey.currentState!.validate()) {
                            if (password == passwordController.text) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else {
                              showSnackbar();
                            }
                          }
                        },
                        child: Text("Login")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(TextSpan(
                        text: "Don't already have an account? ",
                        style: TextStyle(fontSize: 15),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                              text: "Register",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline))
                        ]))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnackbar() {
    final snackbar =
        SnackBar(content: Text("Username and password does not match"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  togglePassword() {
    obscurePassword = !obscurePassword;
    setState(() {});
  }
}
