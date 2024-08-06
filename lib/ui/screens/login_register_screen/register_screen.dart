import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/data/repository/user_repository.dart';
import 'package:soft_me/data/services/auth_dio_services.dart';
import 'package:soft_me/ui/screens/login_register_screen/login_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:soft_me/logic/blocs/auth_bloc/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(
          name: nameController.text,
          surname: surNameController.text,
          username: userNameController.text,
          password: passwordController.text,
        ),
      );
      // try {
      //   if (!mounted) return;
      // } catch (e) {
      //   String message = e.toString();

      //   if (!mounted) return;

      //   showDialog(
      //     context: context,
      //     builder: (ctx) {
      //       return AlertDialog(
      //         title: const Text("Xatolik"),
      //         content: Text(message),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(ctx).pop();
      //             },
      //             child: const Text("OK"),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    surNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        usersRepository: UserRepository(
          dioUserService: AuthDioServices(),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(36, 33, 149, 243),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(1, 33, 149, 243),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoadedAuthState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            } else if (state is ErrorAuthState) {
              setState(() {
                errorMessage = state.message;
              });
              // print(errorMessage);
              if (errorMessage != null) {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Xatolik"),
                      content: Text(errorMessage ?? "Nimadir xato ketti"),
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
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 119, 255),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                labelText: "Name",
                                labelStyle: const TextStyle(color: Colors.grey),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Input Name";
                                }
                                if (value.length < 3) {
                                  return "Name length min 3";
                                }
                                return null;
                              },
                            ),
                            // if (errorMessage != null) ...[
                            //   const SizedBox(height: 10),
                            //   Text(
                            //     errorMessage!,
                            //     style: const TextStyle(color: Colors.red),
                            //   ),
                            // ],
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: surNameController,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                labelText: "Surname",
                                labelStyle: const TextStyle(color: Colors.grey),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Input Surname";
                                }
                                if (value.length < 3) {
                                  return "Surname length min 3";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                labelText: "User Name",
                                labelStyle: const TextStyle(color: Colors.grey),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Input User Name";
                                }
                                if (value.length < 3) {
                                  return "Username length min 3";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                labelText: "Password",
                                labelStyle: const TextStyle(color: Colors.grey),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Input Password";
                                }
                                if (value.length < 6) {
                                  return "Password min 6";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ZoomTapAnimation(
                        onTap: () => submit(context),
                        child: state is LoadingAuthState
                            ? const CircularProgressIndicator()
                            : Container(
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(244, 33, 54, 215),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
