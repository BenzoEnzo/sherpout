enum Weekday {
  monday(1, "monday", "mondayShortcut"),
  tuesday(2, "tuesday", "tuesdayShortcut"),
  wednesday(3, "wednesday", "wednesdayShortcut"),
  thursday(4, "thursday", "thursdayShortcut"),
  friday(5, "friday", "fridayShortcut"),
  saturday(6, "saturday", "saturdayShortcut"),
  sunday(7, "sunday", "sundayShortcut");

  final int value;
  final String namePlaceholder;
  final String shortcutPlaceholder;

  const Weekday(this.value, this.namePlaceholder, this.shortcutPlaceholder);

}