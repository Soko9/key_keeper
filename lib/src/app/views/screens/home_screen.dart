import 'package:flutter/material.dart';
import 'package:key_keeper/src/app/views/screens/screens.dart';
import 'package:key_keeper/src/app/views/widgets/bottom_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAddClicked = false;

  void _updateAddClicked(bool isClicked) {
    setState(() {
      _isAddClicked = isClicked;
    });
  }

  bool _isPasswordChoosen = false;

  void _updatePasswordChoosen(bool value) {
    setState(() {
      _isPasswordChoosen = value;
    });
  }

  int _currentScreenIndex = 0;

  void _updateScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: BottomMenu(
          currentIndex: _currentScreenIndex,
          onTap: _updateScreen,
          isAddClicked: _isAddClicked,
          updateAddClicked: _updateAddClicked,
          updatePasswordChoosen: _updatePasswordChoosen,
        ),
        body: [
          const PasswordsScreen(),
          const NotesScreen(),
          _isAddClicked && _isPasswordChoosen
              ? const AddPasswordScreen()
              : _isAddClicked && !_isPasswordChoosen
                  ? const AddNoteScreen()
                  : const SizedBox.shrink(),
          const GeneratePasswordScreen(),
          const SettingsScreen(),
        ][_currentScreenIndex],
      ),
    );
  }
}
