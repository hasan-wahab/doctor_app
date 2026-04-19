import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_events.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/api_service/api_service.dart';
import '../../../widgets/show_msg.dart';
import '../bloc/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;
  bool obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          children: [
            SizedBox(height: 96.h),
            Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/main_logo.png'),
                ),
              ),
            ),

            SizedBox(height: 50.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [Text('Login', style: TextStyle(fontSize: 40))],
            ),
            SizedBox(height: 50.h),
            AppTField(
              icon: Icon(Icons.email_outlined, color: AppColors.primaryColor),
              isIconsLeft: false,
              controller: emailController,
              validator: (value) {
                if (value == '') {
                  return 'Please enter your email';
                } else if (value!.contains('@gmail.com') == false) {
                  return 'Your email format is incorrect (@gmail.com)';
                }
                email = value;
                return null;
              },
              hintText: 'Enter your email',
            ),
            SizedBox(height: 20.h),
            AppTField(
              obscureText: obscureText,
              icon: InkWell(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText != true ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primaryColor,
                ),
              ),
              isIconsLeft: false,
              controller: passwordController,
              validator: (value) {
                if (value == '') {
                  return 'Please enter your password';
                }
                password = value;
                return null;
              },
              hintText: 'Enter your password',
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.restPassword);
                  },
                  child: Text(
                    'Forget password?',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  isLoading = false;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.naveBar,
                    (Route<dynamic> route) => false,
                  );
                } else if (state is LoginErrorState) {
                  isLoading = false;
                  if (kDebugMode) {
                    print(state.error);
                  }
                  AppMsg.showErrorMsg(context, msg: state.error.toString());
                } else if (state is LoginLoadingState) {
                  isLoading = true;
                }
              },
              builder: (context, state) {
                return isLoading == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      )
                    : AppButton(
                        text: 'Login',
                        onTap: () async {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            context.read<LoginBloc>().add(
                              LoginSignInEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
