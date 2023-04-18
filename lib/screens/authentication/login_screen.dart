import 'package:firebase_auth/firebase_auth.dart';

import 'package:first_project/screens/home/home_screen.dart';
import 'package:first_project/screens/authentication/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegExp regExp = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.7,
              fit: BoxFit.cover,
              image:
                  //  NetworkImage(
                  //     'https://thumbs.dreamstime.com/z/african-american-cheerful-people-holding-shopping-bags-new-clothes-sales-discounts-full-length-body-size-view-portrait-213447345.jpg')

                  AssetImage('lib/assets/images/loginBg.jpg')),
        ),
        child: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
              child: Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/images/logo2.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    // border: Border.all(
                    //   width: 2,
                    // ),
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(fontSize: 28, color: Colors.brown),
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
                                  // color: Colors.white,
                                  // border: Border.all(width: 0.2),
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
                            Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  // border: Border.all(width: 0.2),
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
                        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
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
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text)
                                          .then((value) {
                                        Navigator.of(context).pop();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    HomeScreen())),
                                            (route) => false);

                                        _emailController.text = '';
                                        _passwordController.text = '';
                                      }, onError: ((error, stackTrace) {
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return AlertDialog(
                                                title: const Text('Warning!'),
                                                content: const Text(
                                                    'Wrong email or password'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Retry'))
                                                ],
                                              );
                                            }));
                                      }));
                                    }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) =>
                                      const RegistrationScreen())));
                            },
                            child: Column(
                              children: const [
                                Text("Don't  have an account?"),
                                Text("Sign up"),
                              ],
                            )),
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
