import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:key_keeper/src/core/helpers/helpers.dart';
import '../../../core/utils/utils.dart';

class GeneratePasswordScreen extends StatefulWidget {
  const GeneratePasswordScreen({super.key});

  @override
  State<GeneratePasswordScreen> createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  String _password = '';
  final Map<PasswordElement, bool> _elements = {
    PasswordElement.lowerCase: true,
    PasswordElement.upperCase: false,
    PasswordElement.digits: true,
    PasswordElement.symbols: false,
  };
  int _length = 8;

  void _setPassword(String pass) {
    setState(() {
      _password = pass;
    });
  }

  void _toggleElement(PasswordElement element) {
    final isEnabled = _elements[element]!;
    setState(() {
      _elements[element] = !isEnabled;
    });
  }

  void _setLength(int value) {
    setState(() {
      _length = value;
    });
  }

  void _generatePassword() {
    final enabledElements = <PasswordElement>[];
    for (final element in _elements.entries) {
      if (element.value) {
        enabledElements.add(element.key);
      }
    }
    _setPassword(
      PasswordHelper.generatePassword(
        _length,
        enabledElements,
      ),
    );
  }

  void _lowerCasePressed() {
    ToastHelper.snackBar(
      context: context,
      title: 'DONE',
      content: 'Lower Case can\'t be Disabled',
    );
  }

  void _copyPassword() {
    Clipboard.setData(ClipboardData(text: _password));

    ToastHelper.snackBar(
      context: context,
      title: 'DONE',
      content: 'Password Copied',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: [
                  const Text(
                    'Generate Password',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.gapV,
                  _buildElement(theme, PasswordElement.lowerCase),
                  _buildElement(theme, PasswordElement.upperCase),
                  _buildElement(theme, PasswordElement.digits),
                  _buildElement(theme, PasswordElement.symbols),
                  8.gapV,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4.0,
                    children: [
                      Slider(
                        value: _length.toDouble(),
                        onChanged: (value) => _setLength(value.toInt()),
                        min: 8.0,
                        max: 24.0,
                        divisions: 16,
                        label: _length.toString(),
                      ),
                      Text(
                        'Password Length ($_length)',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  8.gapV,
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _generatePassword,
                      child: const Text('generate'),
                    ),
                  ),
                  8.gapV,
                  if (_password.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        spacing: 12.0,
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                _password,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _copyPassword,
                            icon: const Icon(FontAwesomeIcons.copy),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElement(ThemeData theme, PasswordElement element) {
    return FilterChip(
      backgroundColor: theme.colorScheme.primaryContainer,
      selectedColor: theme.colorScheme.primary,
      label: Text(element.name),
      labelStyle: theme.textTheme.bodyLarge!.copyWith(
        fontSize: 18.0,
        color: element == PasswordElement.lowerCase
            ? theme.textTheme.headlineLarge?.color?.withValues(alpha: 0.5)
            : _elements[element]!
                ? theme.textTheme.headlineLarge?.color
                : theme.textTheme.bodyLarge?.color,
      ),
      onSelected: (_) => element == PasswordElement.lowerCase
          ? _lowerCasePressed()
          : _toggleElement(element),
      showCheckmark:
          element == PasswordElement.lowerCase ? false : _elements[element],
      selected:
          element == PasswordElement.lowerCase ? true : _elements[element]!,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2.0, color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
