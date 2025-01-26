import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/utils.dart';

import 'password_checker.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final bool withChecker;

  const PasswordInput({
    super.key,
    required this.controller,
    this.withChecker = true,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isPasswordHidden = true;
  double _passwordStrength = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _isPasswordHidden,
          onChanged: (value) {
            setState(() {
              _passwordStrength = PasswordHelper.validateStrength(value);
            });
          },
          decoration: InputDecoration(
            hintText: 'Master Password',
            suffixIconConstraints: const BoxConstraints.tightFor(),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordHidden = !_isPasswordHidden;
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              constraints: const BoxConstraints.tightFor(),
              padding: const EdgeInsets.only(right: 12.0),
              icon: Icon(
                _isPasswordHidden
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Master Password Is Required';
            }
            if (value.length < 6) {
              return 'Master Password Must Be At Least 6 Characters';
            }
            return null;
          },
        ),
        if (widget.withChecker) 8.gapV,
        if (widget.withChecker)
          PasswordChecker(
            value: _passwordStrength,
            password: widget.controller.text,
          ),
      ],
    );
  }
}
