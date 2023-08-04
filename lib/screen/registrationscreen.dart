import 'package:firebase_atuhenter/Services/authenticationservices.dart';
import 'package:firebase_atuhenter/screen/applayout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();
  final AuthenticationServices _auth = AuthenticationServices();

  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isObscured = true;
    final size = AppLayout.getSize(context);
    return Scaffold(
      extendBody: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.deepPurpleAccent,
          ),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Gap(AppLayout.getHeight(50)),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: _nameContoller,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      label: Text("Name"),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Gap(AppLayout.getHeight(5)),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: _emailContoller,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .red), // Customize the border color for errors
                      ),
                      labelText:
                          "Email", // Use labelText instead of label and Text widget
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!isValidEmail(value)) {
                        return 'Invalid email'; // Return an error if the email format is invalid
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Gap(AppLayout.getHeight(10)),
                SizedBox(
                  width: size.width * 0.8,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return TextFormField(
                        obscureText: _isObscured,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            // Use GestureDetector instead of InkWell
                            onTap: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            child: Icon(
                              _isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          label: const Text("Password"),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else {
                            return null;
                          }
                        },
                      );
                    },
                  ),
                ),
                Gap(AppLayout.getHeight(5)),
                Padding(
                  padding: EdgeInsets.all(AppLayout.getHeight(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_key.currentState!.validate()) {
                            createNewUser();
                          }
                        },
                        child: SizedBox(
                          width: size.width * 0.2,
                          child: const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _nameContoller.clear();
                          _emailContoller.clear();
                          _passwordController.clear();
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          width: size.width * 0.2,
                          child: const Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToastNotification(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void createNewUser() async {
    dynamic result = await _auth.createNewUser(
        _emailContoller.text, _passwordController.text, _nameContoller.text);
    if (result != null) {
      _nameContoller.clear();
      _emailContoller.clear();
      _passwordController.clear();
      showToastNotification("Successfull");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      showToastNotification("Invalid Email");
    }
  }
}
