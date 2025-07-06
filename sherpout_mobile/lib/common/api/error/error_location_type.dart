enum ErrorLocationType {
  pathParam,
  queryParam,
  headerParam,
  body,
  file;

  static ErrorLocationType? fromName(String name) {
    return ErrorLocationType.values.firstWhere(
      (e) => e.name.toUpperCase() == name.replaceAll("_", ""),
    );
  }
}
