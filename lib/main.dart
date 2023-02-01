import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supertokens/supertokens.dart';
import 'package:supertokensfluttertry/dio.dart';
import 'package:supertokensfluttertry/homeScreen.dart';
import 'package:supertokens/http.dart' as http;

void main() {
  SuperTokens.init(
      apiDomain: 'http://192.168.29.177:3001',
      preAPIHook: (_, req) {
        req.headers.addAll({'appId': 'random#app#Id'});
        return req;
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late bool exist;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (await SuperTokens.doesSessionExist()) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MyHomePage(
                  title: 'Flutter test',
                )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.orange, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () async {
                String url = 'http://192.168.29.177:3001/';
                Dio dio = setupDio(url);
                await dio.post('signIn');
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
