import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/error/api_error_handler.dart';
import '../api/error/error_location_type.dart';
import '../theme/app_colors.dart';
import 'app_form_save_button.dart';

class AppForm<T> extends StatefulWidget {
  final T dto;
  final List<Widget> children;
  final Future<void> Function(T dto) onSubmit;

  const AppForm(
      {super.key,
        required this.dto,
        required this.children,
        required this.onSubmit});

  @override
  _AppFormState<T> createState() => _AppFormState<T>();
}

class _AppFormState<T> extends State<AppForm<T>> {
  final _formKey = GlobalKey<FormState>();
  late T _dto;
  Map<String, List<String>> backendErrors = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _dto = widget.dto;
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setLoading(true);
    try {
      _formKey.currentState!.save();
      await widget.onSubmit.call(_dto);
    } on DioException catch (ex) {
      final handler = ex.error as ApiErrorHandler;

      if (!mounted) return;
      setBackendErrors(handler.getFormBackendErrors(context));
      handler.showRemainingErrors(context, [ErrorLocationType.body]);
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void setBackendErrors(Map<String, List<String>> errors) {
    setState(() {
      backendErrors = errors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._buildFieldsWithSpacing(context),
          Divider(
            color: AppColors.secondary,
            thickness: 1,
            height: 32,
          ),
          AppFormSaveButton(onSubmit: _submit, isLoading: isLoading)
        ],
      ),
    );
  }

  List<Widget> _buildFieldsWithSpacing(BuildContext context) {
    final List<Widget> widgets = [];
    for (int i = 0; i < widget.children.length; i++) {
      widgets.add(widget.children[i]);
      if (i < widget.children.length - 1) {
        widgets.add(const SizedBox(height: 24));
      }
    }
    return widgets;
  }
}