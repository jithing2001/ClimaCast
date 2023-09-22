import 'package:flutter/material.dart';
import 'package:weatherapp/core/style.dart';

class SignupFields extends StatefulWidget {
  String? title;
  String? hint;
  TextEditingController controller = TextEditingController();
  bool? isSuffix;
  final passwordController;
  SignupFields(
      {super.key,
      required this.title,
      required this.hint,
      required this.controller,
      this.isSuffix = false,
      this.passwordController});

  @override
  State<SignupFields> createState() => _SignupFieldsState();
}

class _SignupFieldsState extends State<SignupFields> {
  bool _passwordVisible = true;
  @override
  void initState() {
    // TODO: implement initState

    _passwordVisible = false;
    super.initState();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a ${widget.title}';
    }
    if (widget.title == "Password") {
      RegExp regex = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

      if (!regex.hasMatch(value)) {
        return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and be at least 8 characters long.';
      }
    }
    if (widget.title == "Confirm Password") {
      if (value != widget.passwordController?.text) {
        return 'Passwords do not match';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.title}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          TextFormField(
            obscureText: (widget.isSuffix!) ? !_passwordVisible : false,
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hint,
                suffixIcon: (widget.isSuffix!)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: (_passwordVisible)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off))
                    : const SizedBox(),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10))),
       
            validator: validatePassword,
          ),
          kheight10
        ],
      ),
    );
  }
}
