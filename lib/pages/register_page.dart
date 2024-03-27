// ignore_for_file: must_be_immutable, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:chatapp/services/aurth/authentication.dart';
import 'package:chatapp/utils/ustils.dart';
import 'package:chatapp/widgets/botton.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? ontap;
  RegisterPage({super.key, required this.ontap});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final namecontroller = TextEditingController();

  final passwordController = TextEditingController();

  final repasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? pass;
  String? name;
  String? pass2;

  bool isloding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B475E),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 60),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Image.asset(('lib/assets/images/scholar.png')),
              ),
              Center(
                child: Text(
                  "chatapp",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.purple[600],
                      fontFamily: "pacifico"),
                ),
              ),
              Text(
                "Register",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.purple[300],
                ),
              ),
              CustomFormTextField(
                myController: namecontroller,
                isPassword: false,
                ontap: (name) {
                  this.name = name;
                },
                hint: 'your name',
              ),
              CustomFormTextField(
                myController: emailController,
                isPassword: false,
                ontap: (email) {},
                hint: 'Email',
              ),
              CustomFormTextField(
                myController: passwordController,
                isPassword: true,
                ontap: (pass) {
                  this.pass = pass;
                },
                hint: 'Password',
              ),
              CustomFormTextField(
                confirmedpass: pass,
                myController: repasswordController,
                isPassword: true,
                ontap: (pass2) {
                  this.pass2 = pass2;
                },
                hint: 'Confirm password',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomButton(
                  isloding: isloding,
                  text: 'Register',
                  ontap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isloding = true;
                      });
                      try {
                        await Provider.of<Authentication>(context,
                                listen: false)
                            .signup(emailController.text,
                                passwordController.text, namecontroller.text);
                      } on FirebaseAuthException catch (e) {
                        MyUtils.showmassage(context, e.code);
                      } catch (e) {
                        MyUtils.showmassage(
                            context, 'there was an erorr try again.');
                        print(e);
                      }
                      setState(() {
                        isloding = false;
                      });
                    }
                  },
                ),
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: "have an account  ",
                          style: TextStyle(color: Colors.white)),
                      TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(color: Colors.purple),
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.ontap!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
