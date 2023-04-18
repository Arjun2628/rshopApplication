import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/profile/add_profile.dart';
import 'package:first_project/screens/home/home_screen.dart';
import 'package:first_project/screens/authentication/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isPressed = false;

  final _formKey = GlobalKey<FormState>();
  RegExp regExp = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/assets/images/regBg.webp')),
        ),
        child: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 180, 20, 0),
              child: Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/images/logo2.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    // border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Email :')),
                            ),
                            Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Enter email';
                                    } else if (!regExp.hasMatch(value!)) {
                                      return 'Enter valid email';
                                    }
                                  },
                                  enableSuggestions: true,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Password :')),
                            ),

                            // ),
                            Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Enter password';
                                    } else if (value!.length < 6) {
                                      return 'password in 6 characters';
                                    }
                                  },
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      hintText: 'password'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) =>
                                setState(() => _isPressed = true),
                            onTapUp: (TapUpDetails details) =>
                                setState(() => _isPressed = false),
                            onTapCancel: () =>
                                setState(() => _isPressed = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: _isPressed
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0, 4),
                                          blurRadius: 8,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.lightBlue.withOpacity(0.9),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }));

                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text)
                                          .then((value) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AddProfile())));
                                      });
                                      //  onError: ((error, stackTrace) {

                                      // }));
                                    }
                                  },
                                  child: const Text('Sign up')),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            child: const Text('Already have an account?')),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
