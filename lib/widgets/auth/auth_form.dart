import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // Close soft keyboard
    if (isValid) {
      // Save form data
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );

      // Use those values to send our auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // AnimatedContainer(
          //   duration: const Duration(milliseconds: 300),
          //   margin: const EdgeInsets.all(20),
          //   height: _isLogin ? 260 : 320,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(15),
          //     // boxShadow: [
          //     //   BoxShadow(
          //     //     color: Colors.grey.withOpacity(0.5),
          //     //     spreadRadius: 3,
          //     //     blurRadius: 7,
          //     //   ),
          //     // ],
          //   ),
          Card(
            margin: const EdgeInsets.all(20),
            elevation: 8,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        key: const ValueKey('email'),
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              !value.toString().contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                        ),
                        onSaved: (value) {
                          _userEmail = value.toString();
                        },
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: _isLogin ? 0 : 60,
                        //width: _isLogin ? 0 : 300,
                        child: !_isLogin
                            ? TextFormField(
                                key: const ValueKey('username'),
                                validator: (value) {
                                  if (value.toString().isEmpty ||
                                      value.toString().length < 4) {
                                    return 'Please enter at least 4 characters!';
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                ),
                                onSaved: (value) {
                                  _userName = value.toString();
                                },
                              )
                            : const SizedBox(),
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              value.toString().length < 7) {
                            return 'Password must be at least 7 characters long!';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          _userPassword = value.toString();
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (widget.isLoading)
                        const CircularProgressIndicator(
                            semanticsLabel: 'Loading'),
                      if (!widget.isLoading)
                        ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                        ),
                      if (!widget.isLoading)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'I already have an account'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
