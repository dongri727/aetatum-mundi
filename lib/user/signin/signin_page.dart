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
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
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
                        Text('Do you already have your account ?',
                            style: MundiTheme.textTheme.headlineMedium
                        ),
                        TextField(
                          controller: model.nameController,
                          decoration: const InputDecoration(
                            hintText: 'username',
                          ),
                          onChanged: (text) {
                            model.setEmail(text);
                          },
                        ),
                        TextField(
                          controller: model.emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          onChanged: (text) {
                            model.setEmail(text);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: model.passwordController,
                          decoration: const InputDecoration(
                            hintText: 'password',
                          ),
                          obscureText: true,
                          onChanged: (text) {
                            model.setPassword(text);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
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
            );
          }),
        ),
      ),
    );
  }
}
