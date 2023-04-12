import 'package:flutter/material.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';
import 'package:mcq_generation_flutter/data/data/data_box.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8,
            vertical: MediaQuery.of(context).size.width / 10),
        children: const [
          // Menu(),
          Body(),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Intelligent \nE-Learning System',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Automatic MCQs Generation",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'images/illustration-2.png',
                width: 300,
              ),
            ],
          ),
        ),
        Image.asset(
          'images/illustration-1.png',
          width: 300,
        ),

        /// form
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: const SizedBox(
            width: 320,
            child: _LoginForm(),
          ),
        )
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSignIn = true;
  bool _showPass = false;

  Widget _unSelectedButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _isSignIn = !_isSignIn;
        });
      },
      child: Column(
        children: [
          Text(
            _isSignIn ? 'Sign Up' : 'Sign In',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
            ),
          )
        ],
      ),
    );
  }

  Widget _selectedButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            spreadRadius: 10,
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        _isSignIn ? 'Sign In' : 'Sign Up',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _continueButton() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple[100]!,
              spreadRadius: 10,
              blurRadius: 20,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(_isSignIn ? "Sign In" : 'Sign Up'),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// login signup button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: _isSignIn ? TextDirection.ltr : TextDirection.rtl,
            children: [
              _selectedButton(),
              const SizedBox(width: 30),
              _unSelectedButton(),
            ],
          ),
          const SizedBox(height: 40),

          /// forms

          /// name
          if (!_isSignIn) ...[
            TextFormField(
              controller: _nameCtrl,
              validator: (s) {
                if (s == null) return 'Enter a name';
                if (s.trim().isEmpty) return 'Enter a name';
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter name',
                filled: true,
                fillColor: Colors.blueGrey[50],
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding: const EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[50]!),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[50]!),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],

          /// email
          TextFormField(
            controller: _emailCtrl,
            validator: (s) {
              if (s == null) return 'Enter an email';
              if (s.trim().isEmpty) return 'Enter an email';

              if (_isSignIn && _userFromEmail == null) {
                return 'User not registered!';
              }

              if (!_isSignIn && _userFromEmail != null) {
                return 'User already registered!';
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter email',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 30),

          /// password
          TextFormField(
            controller: _passCtrl,
            obscureText: !_showPass,
            validator: (s) {
              if (s == null) return 'Password is required';
              if (s.trim().isEmpty) return 'Password is required';

              if (_isSignIn &&
                  _userFromEmail != null &&
                  _userFromEmail!.password != s) {
                return 'Invalid Password!';
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: 'Password',
              counterText: _isSignIn ? 'Forgot password?' : null,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _showPass = !_showPass;
                  });
                },
                child: Icon(
                  _showPass ? Icons.visibility : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 40),

          /// continue button
          _continueButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  UserData? get _userFromEmail => DataBox.userBox.get(_emailCtrl.text.trim());

  void _onButtonPressed() {
    final validated = _formKey.currentState?.validate() ?? false;
    if (!validated) return;

    if (_isSignIn) {
      DataBox.login(_userFromEmail!);
    } else {
      DataBox.signup(UserData(_nameCtrl.text, _emailCtrl.text, _passCtrl.text));
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }
}
