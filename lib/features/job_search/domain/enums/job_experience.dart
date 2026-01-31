enum JobExperience {
  noExperience('No Experience', 'no_experience'),
  under3Years('Under 3 Years', 'under_3_years_experience'),
  over3Years('Over 3 Years', 'more_than_3_years_experience');

  final String label;
  final String apiValue;

  const JobExperience(this.label, this.apiValue);
}

/// UI:
/// JobExperience.values.map((e) => e.label)

/// API:
/// job_requirements = selectedExperiences
///     .map((e) => e.apiValue)
///     .join(',')

