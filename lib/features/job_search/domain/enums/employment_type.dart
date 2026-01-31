enum EmploymentType {
  fullTime('Full-time', 'FULLTIME'),
  partTime('Part-time', 'PARTTIME'),
  contractor('Contract', 'CONTRACTOR'),
  intern('Intern', 'INTERN');

  final String label;
  final String apiValue;

  const EmploymentType(this.label, this.apiValue);
}

/// Usage:
/// UI: multi-select chips
/// API: employment_types = selected.map((e) => e.apiValue).join(',')
