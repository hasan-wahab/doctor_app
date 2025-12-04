import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_api_service/auth_api_services.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [Text('Login', style: TextStyle(fontSize: 40))],
            ),
            SizedBox(height: 50.h),
            AppTField(
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
            isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  )
                : AppButton(
                    text: 'Login',
                    onTap: () async {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        isLoading = true;
                        setState(() {});
                        await AuthApiServices.loginApi(
                          context,
                          email: email.toString(),
                          password: password.toString(),
                        );
                        isLoading = false;
                        setState(() {});
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
