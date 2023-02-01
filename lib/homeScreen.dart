import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supertokens/supertokens.dart';
import 'package:supertokens/http.dart' as http;
import 'package:supertokensfluttertry/dio.dart';
import 'package:supertokensfluttertry/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ButtonStyle style = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.orange),
    maximumSize: MaterialStateProperty.all(const Size(90, 50)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Supertokens new flutter SDK',
          style: const TextStyle(color: Colors.orange, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style.copyWith(
                      maximumSize:
                          MaterialStateProperty.all(const Size(90, 200))),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text((await SuperTokens.doesSessionExist())
                            .toString())));
                  },
                  child: Text('DoesSessionExist'),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style,
                  onPressed: () async {
                    try {
                      var test = (await SuperTokens.getUserId()).toString();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(test)));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Get user ID'),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style,
                  onPressed: () async {
                    try {
                      Map<String, dynamic> x =
                          await SuperTokens.getAccessTokenPayloadSecurely();
                      print(x);
                    } on SuperTokensException catch (y, e) {
                      // print(e.toString());
                      print(y.cause);
                    }
                  },
                  child: Text('get access token payload'),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style,
                  onPressed: () async {
                    try {
                      String url = 'http://192.168.29.177:3001/';
                      Dio dio = setupDio(url);
                      var resp = await dio.get('verifySession');
                      print(resp.statusCode);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('VerifySession'),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style,
                  onPressed: () async {
                    await SuperTokens.signOut();
                  },
                  child: Text('signOut'),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    SharedPreferences.getInstance().then((value) {
                      value.getKeys().forEach((element) {
                        print('$element ===> ${value.get(element)}');
                      });
                    });
                  },
                  child: Text('print shared preferences'),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    SharedPreferences.getInstance().then((value) {
                      Map<String, dynamic> cookies = jsonDecode(value
                          .get('supertokens-persistent-cookies')
                          .toString());
                      cookies.entries.forEach((element) {
                        print('${element.key} ==> ${element.value}');
                      });
                    });
                  },
                  child: Text('print cookies'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
