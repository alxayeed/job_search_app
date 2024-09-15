extension MonthToYear on int{
  int convertToYear() {
    int experienceInYears = (this ~/ 12);
    return experienceInYears;
  }
}