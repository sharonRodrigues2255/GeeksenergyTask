import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/controller/registration_and_login_controller.dart';
import 'package:flutter_application_4/model/user_model.dart';
import 'package:flutter_application_4/view/home_screen.dart';
import 'package:flutter_application_4/view/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool obscurePassword = true;
  String? selectedProfession;
  RegistraionAndLoginController dbController = RegistraionAndLoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Registration",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field can't be empty";
                      } else if (dbController.mydb.keys.contains(value)) {
                        return "Username is already taken";
                      } else if (value.length < 3) {
                        return "User name must be atleast 3 letters";
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
                  TextFormField(
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Email can't be empty";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                          .hasMatch(email)) {
                        return "Enter a valid email address";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: (phone) {
                      if (phone == null || phone.isEmpty) {
                        return "Phone number can't be empty";
                      } else if (!RegExp(r"^[0-9]{10}$").hasMatch(phone)) {
                        return "Enter a valid 10-digit phone number";
                      } else {
                        return null;
                      }
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.work),
                        SizedBox(width: 10),
                        DropdownButton(
                          hint: selectedProfession == null
                              ? Text("Select Profession")
                              : null,
                          value: selectedProfession,
                          items: professions.map((String profession) {
                            return DropdownMenuItem(
                              value: profession,
                              child: Text(profession),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedProfession = newValue ?? "";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              dbController.addUserInfo(UserModel(
                                  userName: userNameController.text,
                                  password: passwordController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  profession: selectedProfession));
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          },
                          child: Text("Register")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                          text: "Do you already have an account? ",
                          style: TextStyle(fontSize: 15),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                text: "Login",
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
      ),
    );
  }

  togglePassword() {
    obscurePassword = !obscurePassword;
    setState(() {});
  }
}

List<String> professions = [
  'Doctor',
  'Engineer',
  'Teacher',
  'Software Developer',
  'Artist',
];
