enum JobCountry {
  argentina('Argentina', 'ar'),
  australia('Australia', 'au'),
  bangladesh('Bangladesh', 'bd'),
  brazil('Brazil', 'br'),
  canada('Canada', 'ca'),
  china('China', 'cn'),
  france('France', 'fr'),
  germany('Germany', 'de'),
  india('India', 'in'),
  indonesia('Indonesia', 'id'),
  italy('Italy', 'it'),
  japan('Japan', 'jp'),
  mexico('Mexico', 'mx'),
  netherlands('Netherlands', 'nl'),
  nigeria('Nigeria', 'ng'),
  pakistan('Pakistan', 'pk'),
  philippines('Philippines', 'ph'),
  southAfrica('South Africa', 'za'),
  southKorea('South Korea', 'kr'),
  spain('Spain', 'es'),
  sweden('Sweden', 'se'),
  switzerland('Switzerland', 'ch'),
  turkey('Turkey', 'tr'),
  unitedArabEmirates('United Arab Emirates', 'ae'),
  unitedKingdom('United Kingdom', 'gb'),
  unitedStates('United States', 'us');

  final String label;
  final String apiValue;

  const JobCountry(this.label, this.apiValue);
}

/// Usage:
/// UI: JobCountry.values.map((e) => e.label)
/// API: country = selectedCountry.apiValue
