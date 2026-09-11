import 'dart:io';

import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_ui.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_empty_state.dart';
import 'package:doctor_app/widgets/app_shimmer.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool isLoading = false;
  String? selectedGender;
  String? cnic;
  String? birthDate;
  DateTime? pickedDate;
  File? pickImage;
  CurrentPatientModel? currentPatientModel;
  LoginModel1? profileData;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(MyProfileEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _fillFromModel(CurrentPatientModel model) {
    final patient = model.patient;
    if (patient == null) return;
    _nameController.text = patient.displayName;
    _phoneController.text = patient.displayPhone;
    _emailController.text = patient.displayEmail;
    cnic = patient.displayCnic;
    birthDate = patient.displayBirthDate;
    selectedGender = _normalizeGender(patient.gender);
    pickedDate = DateTime.tryParse(patient.birthDate ?? '');
  }

  String? _normalizeGender(String? value) {
    final gender = (value ?? '').trim().toLowerCase();
    if (gender == 'male') return 'Male';
    if (gender == 'female') return 'Female';
    return null;
  }

  bool get _hasDob =>
      pickedDate != null || (birthDate != null && birthDate!.isNotEmpty);

  String get _dobLabel {
    if (pickedDate != null) {
      return DateAndTimeFormater.dateFormat(pickedDate!.toIso8601String());
    }
    final formatted = DateAndTimeFormater.dateFormat(birthDate);
    return formatted.isEmpty ? 'Select date' : formatted;
  }

  Future<void> _pickImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null || !mounted) return;
    setState(() => pickImage = File(picker.path));
  }

  Future<void> _pickDate() async {
    final initial = pickedDate ?? DateTime.now();
    final next = await showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      initialDate: initial.isAfter(DateTime.now()) ? DateTime.now() : initial,
    );
    if (next == null || !mounted) return;
    setState(() {
      pickedDate = next;
      birthDate = DateFormat('yyyy-MM-dd').format(next);
    });
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    if (selectedGender == null) {
      AppMsg.showSnackBar(context, message: 'Please select gender');
      return;
    }
    if (birthDate == null || birthDate!.isEmpty) {
      AppMsg.showSnackBar(context, message: 'Please select date of birth');
      return;
    }

    context.read<ProfileBloc>().add(
      UpdateProfileEvent(
        path: pickImage,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        cnic: cnic ?? '',
        phone: _phoneController.text.trim(),
        birthDate: birthDate!,
        gender: selectedGender!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        } else if (state is ProfileMessageState) {
          isLoading = false;
          if (kDebugMode) {
            print(state.message);
          }
          AppMsg.showSnackBar(context, message: state.message!);
        } else if (state is MyProfileState) {
          isLoading = false;
          currentPatientModel = state.currentPatientModel;
          profileData = state.profileData;
          if (state.currentPatientModel != null) {
            _fillFromModel(state.currentPatientModel!);
          }
        }
      },
      builder: (context, state) {
        final firstLoad = isLoading && currentPatientModel == null;
        final patient = currentPatientModel?.patient;

        return Scaffold(
          backgroundColor: AppColors.screenBgColor,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBar(
            title: 'Update profile',
            showBack: true,
            isLoading: isLoading,
          ),
          body: firstLoad
              ? const AppListShimmer()
              : patient == null || profileData == null
              ? AppEmptyRefreshView(
                  child: AppEmptyState(
                    title: 'Profile unavailable',
                    subtitle: 'Pull to refresh or try again.',
                    onRetry: () =>
                        context.read<ProfileBloc>().add(MyProfileEvent()),
                  ),
                )
              : SafeArea(
                  top: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: AppSizes.contentMaxWidth(context),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: AppSizes.pageInsets,
                          child: Column(
                            children: [
                              ProfileHeaderCard(
                                name: _nameController.text.isEmpty
                                    ? patient.displayName
                                    : _nameController.text,
                                patientId: patient.displayId,
                                imageUrl: patient.displayImageUrl,
                                token: profileData!.accessToken,
                                file: pickImage,
                                badge: ProfileAvatarBadge(
                                  icon: Icons.camera_alt_outlined,
                                  onTap: _pickImage,
                                ),
                              ),
                              SizedBox(height: AppSizes.spaceXxl),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: _ProfileField(
                                            label: 'Name',
                                            controller: _nameController,
                                            hintText: 'Full name',
                                            prefixIcon:
                                                Icons.person_outline_rounded,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Enter name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(width: AppSizes.gapMd),
                                        Expanded(
                                          child: _ProfileField(
                                            label: 'Phone',
                                            controller: _phoneController,
                                            hintText: 'Phone',
                                            prefixIcon: Icons.phone_outlined,
                                            keyboardType: TextInputType.phone,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Enter phone';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppSizes.spaceMd),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: _LabeledBox(
                                            label: 'Date of birth',
                                            child: InkWell(
                                              onTap:
                                                  isLoading ? null : _pickDate,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                AppSizes.radiusSm,
                                              ),
                                              child: InputDecorator(
                                                decoration: _fieldDecoration(
                                                  prefixIcon: Icons
                                                      .calendar_month_outlined,
                                                ),
                                                child: CustomText(
                                                  text: _dobLabel,
                                                  maxLines: 1,
                                                  style: AppTextStyles.body
                                                      .copyWith(
                                                    color: _hasDob
                                                        ? AppColors
                                                            .firstTextBlackColor
                                                        : AppColors
                                                            .mutedTextColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: AppSizes.gapMd),
                                        Expanded(
                                          child: _LabeledBox(
                                            label: 'Gender',
                                            child: DropdownButtonFormField<
                                                String>(
                                              value: selectedGender,
                                              isExpanded: true,
                                              isDense: true,
                                              style: AppTextStyles.body,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: AppColors.mutedTextColor,
                                                size: AppSizes.iconMd,
                                              ),
                                              decoration: _fieldDecoration(
                                                prefixIcon: Icons.wc_outlined,
                                              ),
                                              hint: CustomText(
                                                text: 'Select',
                                                style: AppTextStyles.body
                                                    .copyWith(
                                                  color:
                                                      AppColors.mutedTextColor,
                                                ),
                                              ),
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 'Male',
                                                  child: Text('Male'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Female',
                                                  child: Text('Female'),
                                                ),
                                              ],
                                              onChanged: isLoading
                                                  ? null
                                                  : (value) {
                                                      setState(
                                                        () => selectedGender =
                                                            value,
                                                      );
                                                    },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Select gender';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppSizes.spaceMd),
                                    _ProfileField(
                                      label: 'Email',
                                      controller: _emailController,
                                      hintText: 'Email address',
                                      prefixIcon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Enter email';
                                        }
                                        return null;
                                      },
                                    ),
                                    const Spacer(),
                                    AppButton(
                                      text: isLoading ? 'Saving...' : 'Update',
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.radiusSm,
                                      ),
                                      onTap: isLoading ? null : _submit,
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
                ),
        );
      },
    );
  }

  InputDecoration _fieldDecoration({required IconData prefixIcon}) {
    final radius = BorderRadius.circular(AppSizes.radiusSm);
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: AppColors.bgColor,
      prefixIcon: Icon(
        prefixIcon,
        size: AppSizes.iconMd,
        color: AppColors.mutedTextColor,
      ),
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
    );
  }
}

class _LabeledBox extends StatelessWidget {
  const _LabeledBox({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          style: AppTextStyles.label.copyWith(
            color: AppColors.firstTextBlackColor,
          ),
        ),
        SizedBox(height: AppSizes.spaceXs),
        child,
      ],
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.label,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.keyboardType,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusSm);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          style: AppTextStyles.label.copyWith(
            color: AppColors.firstTextBlackColor,
          ),
        ),
        SizedBox(height: AppSizes.spaceXs),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: AppTextStyles.body,
          validator: validator,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.mutedTextColor,
            ),
            filled: true,
            fillColor: AppColors.bgColor,
            prefixIcon: Icon(
              prefixIcon,
              size: AppSizes.iconMd,
              color: AppColors.mutedTextColor,
            ),
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
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.5.w,
              ),
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
        ),
      ],
    );
  }
}
