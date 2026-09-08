import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/auth/login/login_screen.dart';

import '../../../core/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreedToTerms = false;
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // await authService.register(...);

    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          //Title
          SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Create Account",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 45),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  "Start collecting the recipe that you'll actually cook again",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        //Form
        Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
            TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return "Please enter your full name";
              }
              if (value.length < 3) {
                return "Full name must be at least 3 characters";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return "Please enter your email";
              }
              if (!value.contains("@")) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return "Please enter your password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: !_isPasswordVisible
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              ),
            ),
          ),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Enter your password",
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible =
                    !_isConfirmPasswordVisible;
                  });
                },
                icon: !_isConfirmPasswordVisible
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              ),
            ),
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return "Please enter your password";
              }
              if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _agreedToTerms,
                onChanged: (value) {
                  setState(() {
                    _agreedToTerms = value ?? false;
                  });
                },
              ),
              Text("I agree to the terms and conditions"),
            ],
          ),
          SizedBox(
            width: 250,
            height: 55,
            child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.petrol,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    ],
    ),
    ),

    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    "Already have an account?",
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    },
    child: Text("Log In"),
    ),
    ],
    ),
    ],
    ),
    )
    ,
    );
  }
}
