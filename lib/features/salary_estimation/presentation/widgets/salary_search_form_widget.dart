import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/salary_estimation_bloc.dart';

class SalarySearchFormWidget extends StatefulWidget {
  final TextEditingController jobTitleController;
  final TextEditingController locationController;

  const SalarySearchFormWidget({
    Key? key,
    required this.jobTitleController,
    required this.locationController,
  }) : super(key: key);

  @override
  _SalarySearchFormWidgetState createState() => _SalarySearchFormWidgetState();
}

class _SalarySearchFormWidgetState extends State<SalarySearchFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: widget.jobTitleController,
                  hintText: 'Enter Job Title...',
                  fieldName: 'Job Title',
                  prefixIcon: const Icon(Icons.work, color: Colors.blueAccent),
                  validator: (value) => _isSubmitted
                      ? _defaultValidator(value, 'Job Title')
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: widget.locationController,
                  hintText: 'Enter Location...',
                  fieldName: 'Location',
                  prefixIcon:
                      const Icon(Icons.location_on, color: Colors.blueAccent),
                  validator: (value) => _isSubmitted
                      ? _defaultValidator(value, 'Location')
                      : null,
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _searchSalaryEstimation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _defaultValidator(String? value, String fieldName) {
    return (value == null || value.isEmpty) ? '$fieldName is required' : null;
  }

  void _searchSalaryEstimation() {
    setState(() {
      _isSubmitted = true;
    });

    if (_formKey.currentState!.validate()) {
      BlocProvider.of<SalaryEstimationBloc>(context).add(
        GetSalaryEstimationsEvent(
          jobTitle: widget.jobTitleController.text,
          location: widget.locationController.text,
        ),
      );
    }
  }
}
