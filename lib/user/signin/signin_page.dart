import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../domain/mundi_theme.dart';
import 'signin_model.dart';


class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SigninModel>(
      create: (_) => SigninModel(),
      child: Scaffold(
        body: Center(
          child: Consumer<SigninModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 10, 100),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/left.png'),
                      fit: BoxFit.cover,
                    )
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Text('already have your account ?',
                              style: MundiTheme.textTheme.headlineMedium
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: model.nameController,
                              decoration: const InputDecoration(
                                hintText: 'User Name',
                              ),
                              onChanged: (text) {
                                model.setEmail(text);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: model.emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                              onChanged: (text) {
                                model.setEmail(text);
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: model.passwordController,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                              obscureText: true,
                              onChanged: (text) {
                                model.setPassword(text);
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              ),
                              onPressed: () async {
                                model.startLoading();

                                // 追加の処理
                                try {
                                  await model.signin();
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
                                  model.endLoading();
                                }
                              },
                              child: const Text('login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (model.isLoading)
                      Container(
                        color: Colors.black54,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
