import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignUp) {
      return _showError('Imagem não selecionada');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(45),
        bottomRight: Radius.circular(45),
      )),
      color: Colors.transparent,
      margin: const EdgeInsets.all(25),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            if (_formData.isSignUp)
              UserImagePicker(onImagePick: _handleImagePick),
            if (_formData.isSignUp)
              TextFormField(
                key: const ValueKey('name'),
                initialValue: _formData.name,
                onChanged: (name) => _formData.name = name,
                decoration: const InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
                style: const TextStyle(color: Colors.white),
                validator: (localName) {
                  final name = localName ?? '';
                  if (name.trim().length < 5) {
                    return 'Nome deve ter no mínimo 5 caracteres';
                  }
                  return null;
                },
              ),
            TextFormField(
              key: const ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  )),
              style: const TextStyle(color: Colors.white),
              validator: (localEmail) {
                final email = localEmail ?? '';
                if (!email.contains('@')) {
                  return 'Email inválido.';
                }
                return null;
              },
            ),
            TextFormField(
              key: const ValueKey('password'),
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  )),
              style: const TextStyle(color: Colors.white),
              validator: (localPassword) {
                final password = localPassword ?? '';
                if (password.length < 6) {
                  return 'Senha deve ter no mínimo 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff09456c),
              ),
              child: Text(
                _formData.isLogin ? 'Entrar' : 'Cadastrar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formData.toggleAuthMode();
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: Text(
                _formData.isLogin
                    ? 'Criar uma nova conta?'
                    : 'Já possui conta?',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
