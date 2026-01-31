import 'package:flutter/material.dart';
import '../../../domain/entities/job_filter_entity.dart';
import '../../../domain/enums/date_posted.dart';
import '../../../domain/enums/employment_type.dart';
import '../../../domain/enums/job_country.dart';
import '../../../domain/enums/job_experience.dart';

class JobFilterDrawer extends StatefulWidget {
  final JobFilterEntity currentFilters;
  final ValueChanged<JobFilterEntity> onChange;
  final VoidCallback? onApply;
  final VoidCallback? onReset;

  const JobFilterDrawer({
    Key? key,
    required this.currentFilters,
    required this.onChange,
    this.onApply,
    this.onReset,
  }) : super(key: key);

  @override
  State<JobFilterDrawer> createState() => _JobFilterDrawerState();
}

class _JobFilterDrawerState extends State<JobFilterDrawer> {
  late JobFilterEntity _filters;

  static const Color primaryColor = Color(0xFF0066FF);
  static const Color chipUnselectedBg = Color(0xFFF0F5FF);
  static const Color chipUnselectedText = Color(0xFF4A5568);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color surfaceLight = Colors.white;

  @override
  void initState() {
    super.initState();
    _filters = widget.currentFilters;
  }

  void _updateFilters(JobFilterEntity newFilters) {
    setState(() => _filters = newFilters);
    widget.onChange(newFilters);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: double.infinity,
              color: surfaceLight,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16),
                        decoration: const BoxDecoration(
                          color: surfaceLight,
                          border: Border(bottom: BorderSide(color: borderLight)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close, size: 28, color: Colors.black87),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Filters",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Country
                              const Text(
                                "Country",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 52,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(16),
                                  border: const Border.fromBorderSide(BorderSide(color: borderLight)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<JobCountry>(
                                    value: _filters.jobCountry,
                                    isExpanded: true,
                                    icon: const Icon(Icons.expand_more, color: Colors.grey),
                                    items: JobCountry.values.map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c.label),
                                    )).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        _updateFilters(_filters.copyWith(jobCountry: value));
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Chips sections
                              _buildChipsSection<DatePosted>(
                                label: "Date Posted",
                                values: DatePosted.values,
                                selected: _filters.datePosted!,
                                onSelected: (val) => _updateFilters(_filters.copyWith(datePosted: val)),
                              ),
                              const SizedBox(height: 24),
                              _buildChipsSection<EmploymentType>(
                                label: "Employment Type",
                                values: EmploymentType.values,
                                selected: _filters.employmentType!,
                                onSelected: (val) => _updateFilters(_filters.copyWith(employmentType: val)),
                              ),
                              const SizedBox(height: 24),
                              _buildChipsSection<JobExperience>(
                                label: "Experience Level",
                                values: JobExperience.values,
                                selected: _filters.jobExperience!,
                                onSelected: (val) => _updateFilters(_filters.copyWith(jobExperience: val)),
                              ),
                              const SizedBox(height: 24),

                              // Remote Switch
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Remote Jobs Only",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                                  ),
                                  Switch.adaptive(
                                    value: _filters.remoteJobsOnly,
                                    activeColor: primaryColor,
                                    activeTrackColor: primaryColor.withOpacity(0.3),
                                    onChanged: (val) => _updateFilters(_filters.copyWith(remoteJobsOnly: val)),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Radius
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Radius",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text("${_filters.radius.round()} miles",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: primaryColor)),
                                  ),
                                ],
                              ),
                              Slider(
                                min: 0,
                                max: 100,
                                divisions: 100,
                                value: _filters.radius,
                                label: "${_filters.radius.round()} mi",
                                onChanged: (value) => _updateFilters(_filters.copyWith(radius: value)),
                              ),

                              const SizedBox(height: 120),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Bottom Buttons
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                      decoration: BoxDecoration(
                        color: surfaceLight.withOpacity(0.95),
                        border: const Border(top: BorderSide(color: borderLight)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onReset,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: borderLight),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                "Reset",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: widget.onApply,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                "Apply Filters",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsSection<T>({
    required String label,
    required List<T> values,
    required T selected,
    required ValueChanged<T> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: values.map((val) {
              final isSelected = val == selected;
              final String text = (val as dynamic).label;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => onSelected(val),
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : chipUnselectedBg,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : chipUnselectedText,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
