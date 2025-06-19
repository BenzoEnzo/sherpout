import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/form/app_form_save_button.dart';
import 'package:sherpoutmobile/common/form/fields/app_form_field.dart';

class AppForm<T> extends StatefulWidget {
  final T dto;
  final List<AppFormField> children;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._buildFieldsWithSpacing(context),
          SizedBox(height: 32),
          AppFormSaveButton(onSubmit: _submit, isLoading: widget.isLoading)
        ],
      ),
    );
  }

  List<Widget> _buildFieldsWithSpacing(BuildContext context) {
    final List<Widget> widgets = [];
    for (int i = 0; i < widget.children.length; i++) {
      widgets.add(widget.children[i].build(context, _dto));
      if (i < widget.children.length - 1) {
        widgets.add(const SizedBox(height: 24));
      }
    }
    return widgets;
  }
}
