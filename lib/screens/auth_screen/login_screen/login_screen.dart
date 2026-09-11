import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_events.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../core/app_styles/app_sizes.dart';
import '../../../core/app_styles/app_text_styles.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_loading_dialog.dart';
import '../../../widgets/custom_text.dart';
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppSizes.isTablet(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
          context.go(AppRoutes.naveBar);
        } else if (state is LoginErrorState) {
          if (kDebugMode) {
            print(state.error);
          }
          AppMsg.error(context, state.error!);
        }
      },
      builder: (context, state) {
        final isLoggingIn = state is LoginLoadingState;

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Stack(
            children: [
              Positioned(
                top: -80.h,
                right: -60.w,
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withValues(alpha: 0.10),
                  ),
                ),
              ),
              Positioned(
                bottom: -40.h,
                left: -50.w,
                child: Container(
                  width: 160.w,
                  height: 160.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withValues(alpha: 0.08),
                  ),
                ),
              ),
              SafeArea(
                child: Form(
                  key: _formKey,
                  child: isTablet
                      ? Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: AppSizes.contentMaxWidth(context),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              padding: AppSizes.authInsets,
                              children: _loginChildren(),
                            ),
                          ),
                        )
                      : ListView(
                          padding: AppSizes.authInsets,
                          children: _loginChildren(),
                        ),
                ),
              ),
              if (isLoggingIn)
                const AppLoadingOverlay(
                  message: 'Signing in...',
                  subtitle: 'Please wait',
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _loginChildren() {
    return [
      Center(
        child: SizedBox(
          width: AppSizes.logoSize,
          height: AppSizes.logoSize,
          child: Image.asset(
            'assets/images/app_logo.png',
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
      SizedBox(height: AppSizes.spaceXl),
      CustomText(
        text: 'Welcome Patient',
        style: AppTextStyles.heading2,
        align: TextAlign.center,
        textOverflow: TextOverflow.visible,
      ),
      SizedBox(height: AppSizes.spaceXs),
      CustomText(
        text: 'Sign in to Ali Therapy Patient Portal',
        style: AppTextStyles.bodySmall,
        align: TextAlign.center,
        maxLines: 2,
        textOverflow: TextOverflow.visible,
      ),
      SizedBox(height: AppSizes.spaceSection),
      Container(
        width: double.infinity,
        padding: AppSizes.cardInsets,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.firstTextBlackColor.withValues(alpha: 0.05),
              blurRadius: AppSizes.radiusMd,
              offset: Offset(0, AppSizes.spaceSm),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Email',
              style: AppTextStyles.label.copyWith(
                color: AppColors.firstTextBlackColor,
              ),
            ),
            SizedBox(height: AppSizes.spaceSm),
            _LoginField(
              controller: emailController,
              hintText: 'patient@example.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == '') {
                  return 'Please enter your email';
                }
                email = value;
                return null;
              },
            ),
            SizedBox(height: AppSizes.spaceLg),
            CustomText(
              text: 'Password',
              style: AppTextStyles.label.copyWith(
                color: AppColors.firstTextBlackColor,
              ),
            ),
            SizedBox(height: AppSizes.spaceSm),
            _LoginField(
              controller: passwordController,
              hintText: 'Enter password',
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: AppSizes.iconMd,
                  color: AppColors.mutedTextColor,
                ),
              ),
              validator: (value) {
                if (value == '') {
                  return 'Please enter your password';
                }
                password = value;
                return null;
              },
            ),
            SizedBox(height: AppSizes.spaceXl),
            AppButton(
              text: 'Login',
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
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
            ),
          ],
        ),
      ),
      SizedBox(height: AppSizes.pagePaddingBottom),
      CustomText(
        text: 'Ali Therapy Patient Portal',
        style: AppTextStyles.label,
        align: TextAlign.center,
        textOverflow: TextOverflow.visible,
      ),
    ];
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String? value) validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusSm);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.mutedTextColor),
        filled: true,
        fillColor: AppColors.bgColor,
        prefixIcon: Icon(
          prefixIcon,
          size: AppSizes.iconMd,
          color: AppColors.mutedTextColor,
        ),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.fieldPaddingH,
          vertical: AppSizes.fieldPaddingV,
        ),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: AppColors.diagnosisRedColor,
            width: 1.5.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: AppColors.diagnosisRedColor,
            width: 1.5.w,
          ),
        ),
      ),
      validator: (value) => validator(value),
    );
  }
}
