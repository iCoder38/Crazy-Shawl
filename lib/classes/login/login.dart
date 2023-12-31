// ignore_for_file: use_build_context_synchronously

// import 'dart:async';

import 'dart:convert';
// import 'dart:html';

import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:shawl_prod/classes/chat_dialog/chat_dialog.dart';
import 'package:shawl_prod/classes/sign_up/sign_up.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:crypto/crypto.dart';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

import '../Utils/utils.dart';
import '../set_profile_for_public/set_profile_for_public.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController contEmail;
  late final TextEditingController contPassword;
  //
  // static Encrypted? encrypted;
  // static var decrypted;
  //
  @override
  void initState() {
    //
    if (FirebaseAuth.instance.currentUser != null) {
      if (kDebugMode) {
        print('=====> signed in ');
      }
      contEmail =
          TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
    } else {
      if (kDebugMode) {
        print('=====> signed out ');
      }
      contEmail = TextEditingController();
    }

    contPassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    //
    contEmail.dispose();
    contPassword.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: FirebasePhoneAuthProvider(
        child: Scaffold(
          appBar: AppBar(
            title: textWithBoldStyle(
              'Login',
              Colors.black,
              18.0,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: navigationColor,
          ),
          backgroundColor: const Color.fromRGBO(
            254,
            248,
            224,
            1,
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                //
                const SizedBox(
                  height: 20,
                ),
                //
                Row(
                  children: [
                    //
                    const SizedBox(
                      width: 10,
                    ),
                    //
                    Align(
                      alignment: Alignment.topLeft,
                      child: textWithRegularStyle(
                        'Phone number',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ],
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    color: Colors.white,
                    border: Border.all(width: 0.4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 188, 182, 182),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: contEmail,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ex. 9876543210',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                ),
                //

                //
                /*Row(
                  children: [
                    //
                    const SizedBox(
                      width: 10,
                    ),
                    //
                    Align(
                      alignment: Alignment.topLeft,
                      child: textWithRegularStyle(
                        'Password',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ],
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    color: Colors.white,
                    border: Border.all(width: 0.4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 188, 182, 182),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: contPassword,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ),*/
                //

                //
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 60,
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: NeoPopButton(
                      color: navigationColor,
                      // onTapUp: () => HapticFeedback.vibrate(),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      onTapUp: () {
                        //
                        if (formKey.currentState!.validate()) {
                          //
                          verifyUserNumber();
                          // showCustomDialog(context, 'please wait...');
                          // signInViaFirebase();

                          //
                        }
                      },
                      // onTapDown: () => HapticFeedback.vibrate(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWithBoldStyle(
                            'Sign In',
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                const SizedBox(
                  height: 20,
                ),
                //
                /*SizedBox(
                  height: 60,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: NeoPopButton(
                      color: Colors.lightBlueAccent,
                      // onTapUp: () => HapticFeedback.vibrate(),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      onTapUp: () {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                        //
                      },
                      // onTapDown: () => HapticFeedback.vibrate(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWithBoldStyle(
                            'Sign Up',
                            Colors.black,
                            14.0,
                          ),
                          //
                          const Icon(
                            Icons.arrow_forward,
                            size: 20.0,
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                ),*/
                //
                const SizedBox(
                  height: 10,
                ),
                // CHECK EMAIL IS VERIFIED
                (FirebaseAuth.instance.currentUser != null)
                    ? (FirebaseAuth.instance.currentUser!.emailVerified == true)
                        ? const SizedBox(
                            height: 0,
                          ) // email is verified
                        : GestureDetector(
                            onTap: () {
                              if (kDebugMode) {
                                print('=====> resend code button click <=====');
                              }
                              //
                              funcResendCodeToVerifyEmailAddress();
                              //
                            },
                            child: textWithRegularStyle(
                              'resend code',
                              Colors.black,
                              14.0,
                            ),
                          )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyUserNumber() async {
    //
    FirebaseAuth auth = FirebaseAuth.instance;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+918287',
      verificationCompleted: (PhoneAuthCredential credential) {
        if (kDebugMode) {
          print('mobile number verification completed');
        }
        //
        if (kDebugMode) {
          print('credentials');
        }
        // Sign the user in (or link) with the auto-generated credential
        auth.signInWithCredential(credential);
        //
      },
      verificationFailed: (FirebaseAuthException e) {
        if (kDebugMode) {
          print('mobile number verification failed');
        }
        //
        if (e.code == 'invalid-phone-number') {
          if (kDebugMode) {
            print('The provided phone number is not valid.');
          }
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (kDebugMode) {
          print('mobile number verification code sent');
        }
        //
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        auth.signInWithCredential(credential);
        //
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        if (kDebugMode) {
          print('mobile number verification code timeout');
          //
          print(verificationId);
        }
      },
    );
  }

  //
  funcResendCodeToVerifyEmailAddress() async {
    //
    showCustomDialog(context, 'sending...');
    //

    FirebaseAuth.instance.currentUser
        ?.sendEmailVerification()
        .then((values) => {
              //
              // print(values),
              Navigator.pop(context),
              //
              popUpWithOutsideClick(
                  context, 'Please check your E-mail address', 'Ok'),
              //
            });
  }

  //
  signInViaFirebase() async {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: contEmail.text, password: contPassword.text);
      // return customUserCredential.user!.uid;
      if (kDebugMode) {
        print(customUserCredential);
      }
      //
      funcCheckIsThisAccountVerifiedOrNot();
      //
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
      }

      customException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
        // print(e);
      }
    }
  }

  //
  funcCheckIsThisAccountVerifiedOrNot() async {
    if (kDebugMode) {
      print(FirebaseAuth.instance.currentUser!.emailVerified);
    }
    Navigator.pop(context);
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      popUpWithOutsideClick(
        context,
        'Your account is not verified yet. Please verify your account by click verification link in your registered E-Mail address.',
        'Ok',
      );
    } else {
      funcPushToLoginScreen();
    }
  }

  //
  funcPushToLoginScreen() {
    //
    Navigator.pop(context);
    //
    //
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetProfileForpublicScreen(),
      ),
    );
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const DialogScreen(),
    //   ),
    // );
    //
  }

  //
  customException(errorMessageIs) {
    //
    Navigator.pop(context);
    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navigationColor,
        content: textWithBoldStyle(
          //
          errorMessageIs.toString(),
          //
          Colors.white,
          14.0,
        ),
      ),
    );
  }
}
