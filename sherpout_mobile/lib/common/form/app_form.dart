import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/form/app_form_save_button.dart';

class AppForm<T> extends StatefulWidget {
  final T dto;
  final List<Widget> children;
  final void Function(T dto) onSubmit;
  final bool isLoading;

  const AppForm({
    super.key,
    required this.dto,
    required this.children,
    required this.onSubmit,
    required this.isLoading
  });

  @override
  _AppFormState<T> createState() => _AppFormState<T>();
}

class _AppFormState<T> extends State<AppForm<T>> {
  final _formKey = GlobalKey<FormState>();
  late T _dto;

  @override
  void initState() {
    super.initState();
    _dto = widget.dto;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit.call(_dto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.children.map((input) => input),
            AppFormSaveButton(onSubmit: _submit, isLoading: widget.isLoading)
        ],
      ),
    );
  }
}
