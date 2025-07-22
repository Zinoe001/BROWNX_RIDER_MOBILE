import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/widgets/app_colors.dart';
import 'package:rider_mobile/widgets/text/textstyles.dart';

class AppTextField extends StatefulWidget {
  final String? text;
  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? textFormStyle;
  final String? labelText;
  final String? Function(String? value)? validator;
  final TextInputType keyboardType;
  final bool isPassword;
  final List<TextInputFormatter> formatter;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? borderColor;
  final bool readOnly;
  final Function(String)? onSubmitted;
  final int? maxLength;
  final double? height;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final EdgeInsets? padding;
  final TextCapitalization textCapitalization;
  final EdgeInsets? contentPadding;
  final bool enabled;
  final bool validCode;
  final Function()? onTap;

  const AppTextField({
    Key? key,
    this.hint,
    this.hintStyle,
    this.textFormStyle,
    this.text,
    this.labelText,
    this.height,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.enabled = true,
    this.validCode = false,
    this.minLines,
    this.readOnly = false,
    this.prefix,
    this.hintColor,
    this.textColor,
    this.borderColor,
    this.contentPadding,
    this.isPassword = false,
    this.formatter = const [],
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.maxLength,
    this.onTap,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscure;

  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
  }

  toggleVisibility() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          child: TextFormField(
            textCapitalization: widget.textCapitalization,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            style:
                widget.textFormStyle ??
                headingStyle6.copyWith(
                  color: widget.textColor ?? AppColors.black,
                  fontSize: 14,
                ),
            controller: widget.controller,
            inputFormatters: widget.formatter,
            onFieldSubmitted: widget.onSubmitted,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            obscureText: obscure,
            enabled: widget.enabled,
            decoration: InputDecoration(
              fillColor: widget.fillColor ?? const Color(0xFFF4F4F4),
              errorStyle: headingStyle6.copyWith(
                color: AppColors.red,
                fontSize: 14,
              ),
              labelText: widget.labelText,
              suffixIconConstraints: BoxConstraints(maxHeight: 30),
              prefixIconConstraints: BoxConstraints(maxHeight: 30),
              prefixIcon: widget.prefixIcon,
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: toggleVisibility,
                        color: AppColors.black.withOpacity(0.6),
                      )
                      : widget.suffixIcon,
              isDense: true,
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.only(top: 20, bottom: 15, left: 20),
              hintText: widget.hint,
              hintStyle:
                  widget.hintStyle ??
                  headingStyle6.copyWith(
                    color:
                        widget.hintColor ?? AppColors.black.withOpacity(0.35),
                    fontSize: 14,
                  ),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide:
                    widget.validCode
                        ? const BorderSide(color: AppColors.green)
                        : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.black,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: const BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.black,
                ),
              ),
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}

class PinCodeField extends StatefulWidget {
  const PinCodeField({
    Key? key,
    this.height,
    this.width,
    required this.otpController,
    required this.length,
    this.onSubmitted,
    this.onCompleted,
    this.textInputAction,
    this.enabled = true,
    this.isCompleted = false,
    this.isError = false,
    this.autoDismissKeyboard,
  }) : super(key: key);
  final double? width;
  final double? height;
  final int length;
  final Function(String)? onSubmitted;
  final Function(String)? onCompleted;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool? autoDismissKeyboard;
  final bool isCompleted;
  final bool isError;
  final TextEditingController otpController;

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  String? text;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDismissKeyboard: widget.autoDismissKeyboard ?? true,
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      keyboardType: TextInputType.number,
      cursorColor: AppColors.primary,
      textStyle: headingStyle3.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontSize: 16,
      ),
      controller: widget.otpController,
      hintStyle: headingStyle6.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        fontSize: 16,
      ),
      appContext: context,
      length: widget.length,
      autoDisposeControllers: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
      onChanged: (value) {
        text = value;
      },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return "OTP Code cannot be empty";
      //   } else if (value.length < widget.length) {
      //     return "Please completly fill your OTP code";
      //   }
      //   return null;
      // },
      enabled: widget.enabled,
      onCompleted: widget.onCompleted,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(6),
        fieldOuterPadding: const EdgeInsets.only(top: 2),
        fieldWidth: min((context.width - 42) / 6, 54),
        fieldHeight: 54,
        borderWidth: 2,
        inactiveColor: const Color(0XFFBEBBBB),
        activeColor:
            widget.isError || widget.isCompleted
                ? widget.isCompleted
                    ? const Color(0XFF40F911)
                    : Colors.red
                : AppColors.primary,
        selectedColor: AppColors.primary,
        errorBorderColor: Colors.red,
      ),
    );
  }
}
