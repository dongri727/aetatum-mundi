import 'package:aetatum_mundi/domain/mundi_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signup_model.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupModel>(
      create: (_) => SignupModel(),
      child: Scaffold(
        body: Center(
          child: Consumer<SignupModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/right.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text('if this is your first time',
                          style: MundiTheme.textTheme.headlineMedium
                          ),
                        TextField(
                          controller: model.nameController,
                          decoration: const InputDecoration(
                            hintText: 'username',
                          ),
                          onChanged: (text) {
                            model.setUsername(text);
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
                              await model.signUp();
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
                          child: const Text('sign-up'),
                        ),
                      ],
                    ),
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
            );
          }),
        ),
      ),
    );
  }
}