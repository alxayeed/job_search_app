import 'package:flutter/material.dart';

import '../../domain/entities/job_filter_entity.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onFilterTap;
  final JobFilterEntity filters;

  const SearchBarWidget({
    required this.controller,
    required this.onSearch,
    required this.onFilterTap,
    required this.filters,
  });

  int getAppliedFilterCount() {
    int count = 0;
    if (filters.remoteJobsOnly) count++;
    if (filters.jobCountry != null) count++;
    if (filters.datePosted != null) count++;
    if (filters.employmentType != null) count++;
    if (filters.jobExperience != null) count++;
    if (filters.radius != null) count++;
    return count;
  }

  String getAppliedFiltersTooltip() {
    List<String> applied = [];
    if (filters.remoteJobsOnly) applied.add("Remote: Yes");
    if (filters.jobCountry != null) applied.add("Country: ${filters.jobCountry!.label}");
    if (filters.datePosted != null) applied.add("Date Posted: ${filters.datePosted!.label}");
    if (filters.employmentType != null) applied.add("Employment: ${filters.employmentType!.label}");
    if (filters.jobExperience != null) applied.add("Experience: ${filters.jobExperience!.label}");
    if (filters.radius != null) applied.add("Radius: ${filters.radius!.round()} mi");
    return applied.isEmpty ? "No filters applied" : applied.join("\n");
  }

  @override
  Widget build(BuildContext context) {
    final appliedCount = getAppliedFilterCount();
    final tooltipText = getAppliedFiltersTooltip();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Job title or keywords',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onFilterTap,
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Applied Filters"),
                      content: Text(tooltipText),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Icon(Icons.tune, color: Color(0xFF0066FF)),
                    ),
                    if (appliedCount > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0066FF),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "$appliedCount",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text(
                "Search Jobs",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
