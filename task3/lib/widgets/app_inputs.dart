import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? ctrl;
  final TextInputType kbType;
  final String? Function(String?)? validator;
  final bool obscure;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputAction inputAction;

  const AppTextField({
    super.key, required this.hint,
    this.ctrl, this.kbType = TextInputType.text,
    this.validator, this.obscure = false,
    this.suffix, this.prefix,
    this.inputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      keyboardType: kbType,
      obscureText: obscure,
      textInputAction: inputAction,
      validator: validator,
      style: AppTypography.body,
      decoration: InputDecoration(hintText: hint, suffixIcon: suffix, prefixIcon: prefix),
    );
  }
}

// eye toggle for pasword visibility
class PasswordInput extends StatefulWidget {
  final TextEditingController? ctrl;
  final String? Function(String?)? validator;
  const PasswordInput({super.key, this.ctrl, this.validator});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: 'Password',
      ctrl: widget.ctrl,
      obscure: !showPass,
      validator: widget.validator,
      inputAction: TextInputAction.done,
      prefix: const Icon(Icons.lock_outline, size: 20),
      suffix: GestureDetector(
        onTap: () { setState(() { showPass = !showPass; }); },
        child: Icon(showPass ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20, color: AppColors.txtSecondary),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final String hint;
  const SearchField({super.key, this.hint = 'Search...'});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: hint,
      prefix: const Icon(Icons.search, color: AppColors.txtSecondary),
      inputAction: TextInputAction.search,
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final String hint;
  final List<String> opts;
  final String? selected;
  final ValueChanged<String?>? onChanged;

  const CategoryDropdown({
    super.key, required this.hint,
    required this.opts, this.selected, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selected,
      items: opts.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.md, vertical: 14)),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.txtSecondary),
    );
  }
}
