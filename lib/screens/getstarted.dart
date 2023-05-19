import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_player/screens/homescreen/homescreen.dart';
import 'package:music_player/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../materials/material.dart';

var name;

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final _formkey = GlobalKey<FormState>();

  final usernamecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                      inset: true,
                    ),
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please Let Us Know',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Your Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter name';
                            }
                            return null;
                          },
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'your Name',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: sendory,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              focusColor: primary),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: sendory,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1.5,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                              inset: true,
                            ),
                          ],
                        ),
                        child: TextButton(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                color: primary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              goTomain(context);
                            }
                          },
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> goTomain(BuildContext context) async {
    final user = usernamecontroller.text;
    final username = await SharedPreferences.getInstance();

    await username.setString('username', user);
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(Save_Key, true);
    name = username.getString('username');
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        username: usernamecontroller.text,
      );
    }));
  }
}
