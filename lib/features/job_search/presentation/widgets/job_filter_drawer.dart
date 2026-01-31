import 'package:flutter/material.dart';
import '../../domain/entities/job_filter_entity.dart';
import '../../domain/enums/date_posted.dart';
import '../../domain/enums/employment_type.dart';
import '../../domain/enums/job_country.dart';
import '../../domain/enums/job_experience.dart';

class JobFilterDrawer extends StatefulWidget {
  final JobFilterEntity currentFilters;
  final ValueChanged<JobFilterEntity> onChange;

  const JobFilterDrawer({
    Key? key,
    required this.currentFilters,
    required this.onChange,
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

  void _resetFilters() {
    setState(() {
      _filters = JobFilterEntity(
        jobCountry: null,
        datePosted: null,
        employmentType: null,
        jobExperience: null,
        remoteJobsOnly: false,
        radius: null,
      );
    });
    widget.onChange(_filters);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(color: Colors.black.withValues(alpha: 0.2)),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: double.infinity,
            color: surfaceLight,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Container(
                  padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
                  decoration: const BoxDecoration(
                    color: surfaceLight,
                    border: Border(bottom: BorderSide(color: borderLight)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, size: 28, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Text(
                        "Filters",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      TextButton(
                        onPressed: _resetFilters,
                        child: const Text(
                          "Clear",
                          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                        ),
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
                        const Text(
                          "Country",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87),
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
                              hint: const Text("Select country"),
                              icon: const Icon(Icons.expand_more, color: Colors.grey),
                              items: JobCountry.values
                                  .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.label),
                              ))
                                  .toList(),
                              onChanged: (value) =>
                                  _updateFilters(_filters.copyWith(jobCountry: value)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildChipsSection<DatePosted>(
                          label: "Date Posted",
                          values: DatePosted.values,
                          selected: _filters.datePosted,
                          onSelected: (val) =>
                              _updateFilters(_filters.copyWith(datePosted: val)),
                        ),
                        const SizedBox(height: 24),
                        _buildChipsSection<EmploymentType>(
                          label: "Employment Type",
                          values: EmploymentType.values,
                          selected: _filters.employmentType,
                          onSelected: (val) =>
                              _updateFilters(_filters.copyWith(employmentType: val)),
                        ),
                        const SizedBox(height: 24),
                        _buildChipsSection<JobExperience>(
                          label: "Experience Level",
                          values: JobExperience.values,
                          selected: _filters.jobExperience,
                          onSelected: (val) =>
                              _updateFilters(_filters.copyWith(jobExperience: val)),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Remote Jobs Only",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87),
                            ),
                            Switch.adaptive(
                              value: _filters.remoteJobsOnly,
                              activeThumbColor: primaryColor,
                              activeTrackColor: primaryColor.withValues(alpha: 0.3),
                              onChanged: (val) =>
                                  _updateFilters(_filters.copyWith(remoteJobsOnly: val)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
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
                                color: primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text("${_filters.radius?.round() ?? 0} miles",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: primaryColor)),
                            ),
                          ],
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          divisions: 100,
                          value: _filters.radius ?? 0,
                          label: "${_filters.radius?.round() ?? 0} mi",
                          onChanged: (value) =>
                              _updateFilters(_filters.copyWith(radius: value)),
                          activeColor: primaryColor,
                          // activeTrackColor: primaryColor.withOpacity(0.3),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChipsSection<T>({
    required String label,
    required List<T> values,
    T? selected,
    required ValueChanged<T> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
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
