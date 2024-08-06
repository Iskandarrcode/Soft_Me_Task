import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:soft_me/ui/screens/login_register_screen/register_screen.dart';
import 'package:soft_me/ui/widgets/navigation_bar/navigation_bar.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? password, userName;

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
          username: userNameController.text,
          password: passwordText.text,
        ),
      );
    }

    try {
      if (!mounted) return;
    } catch (e) {
      String message = e.toString();

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Xatolik"),
            content: Text(message),
            actions:[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(36, 33, 149, 243),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 119, 255),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 50,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: userNameController,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        labelText: "userName",
                        labelStyle: const TextStyle(color: Colors.grey),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Iltimos UserNameni kiriting";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        userName = newValue;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: passwordText,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        labelText: "Enter Password",
                        labelStyle: const TextStyle(color: Colors.grey),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "iltimos parolingizni kiriting";
                        }

                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoadedAuthState) {
                    if (state.isLogged) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const NavigationBars();
                          },
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text("Xatolik"),
                            content:
                                const Text("Bunday Foydalanuvchi Mavjud emas"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  if (state is ErrorAuthState) {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text("Xatolik"),
                          content: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingAuthState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ZoomTapAnimation(
                    onTap: submit,
                    child: Container(
                      width: 328,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(244, 33, 54, 215),
                      ),
                      child: const Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              ZoomTapAnimation(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignupScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 167, 196, 239),
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
