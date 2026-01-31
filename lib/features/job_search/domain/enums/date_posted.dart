enum DatePosted {
  all('All', 'all'),
  today('Today', 'today'),
  last3Days('Last 3 Days', '3days'),
  lastWeek('Last Week', 'week'),
  lastMonth('Last Month', 'month');

  final String label;
  final String apiValue;

  const DatePosted(this.label, this.apiValue);
}

/// Usage:
/// UI: chip.label
/// API: date_posted = selectedDate.apiValue
