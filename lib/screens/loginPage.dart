import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helper/database_helper.dart';
import 'package:login/screens/homePage.dart';
import 'package:login/screens/signupPage.dart';

import '../model/ModelClass.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginpageState();
}

class LoginpageState extends State {
  late DatabaseHelper db;
  List<ModelClass> datas = [];
  int res = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHelper();
    getDatas();
  }

  void getDatas() async {
    datas = await db.getData();
  }

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                      controller: userController,
                      keyboardType: TextInputType.emailAddress,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Username or Email",
                          hintText: "username or email",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
                      validator: (username) {
                        if (isUsernameValidate(username!)) {
                          return null;
                        } else
                          return 'Enter a valid username';
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passController,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    validator: (password) {
                      if (isPasswordValidate(password!)) {
                        return null;
                      } else
                        return "Entered password is too short";
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          String userName = userController.text.toString();
                          String Password = passController.text.toString();

                          for (int i = 0; i < datas.length; i++) {
                            if (datas[i].email.contains(userName) &&
                                datas[i].password.contains(Password)) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            }
                          }
                        }
                      },
                      child: Text(
                        "Login".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a User?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ))
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

  bool isUsernameValidate(String username) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp nameReg = RegExp(pattern);
    return (nameReg.hasMatch(username) && username != null);
  }

  bool isPasswordValidate(String password) {
    // String passpattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>';
    // RegExp passReg = RegExp(passpattern);
    // return passReg.hasMatch(password) && password.length<4;
    String pattern = r'[a-zA-Z0-9]{6,}$';
    RegExp nameReg = RegExp(pattern);
    return (nameReg.hasMatch(password) && password != null);
  }
}
