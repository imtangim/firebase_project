import 'package:firebase_atuhenter/Services/authenticationservices.dart';
import 'package:firebase_atuhenter/screen/applayout.dart';
import 'package:firebase_atuhenter/screen/dashboard.dart';
import 'package:firebase_atuhenter/screen/registrationscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final AuthenticationServices _auth = AuthenticationServices();
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                  "Login",
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
                    controller: _emailContoller,
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
                      label: Text("Email"),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Gap(AppLayout.getHeight(5)),
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
                Gap(AppLayout.getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not registered?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RegisterPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(1.0, 0.0); // Slide in from the right
                              const end = Offset.zero;
                              final tween = Tween(begin: begin, end: end);
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: const Text(
                        "\tSign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(AppLayout.getHeight(20)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_key.currentState!.validate()) {
                      signinuser();
                    }
                  },
                  child: SizedBox(
                    width: size.width * 0.2,
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
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

  void signinuser() async {
    dynamic authresult =
        await _auth.loginUser(_emailContoller.text, _passwordController.text);
    if (authresult == null) {
      showToastNotification("Couldn't not sign you in.");
    } else {
      _emailContoller.clear();
      _passwordController.clear();
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Dashboard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide in from the right
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          fullscreenDialog: true,
        ),
      );
      showToastNotification("Sign in Successfull");
    }
  }
}
