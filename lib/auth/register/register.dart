import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '/auth/login/login.dart';
import '/components/password_text_field.dart';
import '/components/text_form_builder.dart';
import '/utils/validation.dart';
import '/view_models/auth/register_view_model.dart';
import '/widgets/indicators.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    return ModalProgressHUD(
      progressIndicator: circularProgress(context),
      inAsyncCall: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            SizedBox(height: 10.0),
            Text(
              'Bookly-д тавтай морил..\nУншигч бүрд зориулав',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: 'Roboto-Regular'),
            ),
            SizedBox(height: 30.0),
            buildForm(viewModel, context),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (_) => Login()));
                  },
                  child: Text(
                    'Нэвтрэх',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.user,
            hintText: "Нэр",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.usernameFN,
            nextFocusNode: viewModel.emailFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.mail,
            hintText: "Имэйл",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.countryFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.map_pin,
            hintText: "Улс",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setCountry(val);
            },
            focusNode: viewModel.countryFN,
            nextFocusNode: viewModel.passFN,
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.lock,
            suffix: Feather.eye,
            hintText: "Нууц үг",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
            nextFocusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.lock,
            hintText: "Нууц үгээ дахин оруулна уу",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setConfirmPass(val);
            },
            focusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 25.0),
          Container(
            height: 45.0,
            width: 180.0,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor),
              ),
              child: Text(
                'Бүртгүүлэх'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Ubuntu',
                ),
              ),
              onPressed: () => viewModel.register(context),
            ),
          ),
        ],
      ),
    );
  }
}
