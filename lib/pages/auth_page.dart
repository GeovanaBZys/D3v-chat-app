import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        await AuthService().signUp(
          formData.image,
          formData.name,
          formData.email,
          formData.password,
        );
      }
    } catch (error) {
      //tratar o erro futuramente
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.4,
                    0.5,
                    0.7,
                    0.9,
                  ],
                  colors: [
                    Color(0xff005C97),
                    Color(0xff7076E0),
                    Color(0xffAC42A3),
                    Color(0xffB60054),
                    Color(0xff960000),
                  ]),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Center(
                child: SimpleCircularProgressBar(
                  progressColors: const [
                    Color(0xff005C97),
                    Color(0xff7076E0),
                    Color(0xffAC42A3),
                    Color(0xffB60054),
                    Color(0xff960000),
                  ],
                  backStrokeWidth: 0,
                  //mergeMode: true,
                  onGetText: (double value) {
                    return Text('${value.toInt()}%');
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
