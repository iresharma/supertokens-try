import 'package:flutter/material.dart';
import 'package:supertokens/supertokens.dart';
import 'package:supertokens/http.dart' as http;
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
        title: Text(
          'Supertokens new flutter SDK',
          style: const TextStyle(color: Colors.orange, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
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
                      content: Text(
                          (await SuperTokens.doesSessionExist()).toString())));
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
                  print(await SuperTokens.getAccessTokenPayloadSecurely());
                },
                child: Text('get access token payload'),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                style: style,
                onPressed: () async {
                  Uri uri =
                      Uri.parse('http://192.168.29.177:3001/verifySession');
                  try {
                    var resp = await http.get(
                      uri,
                      // headers: {'content-type': 'application/json'},
                    );
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
            )
          ],
        ),
      ),
    );
  }
}
