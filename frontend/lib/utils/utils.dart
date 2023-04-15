DateTime? dateTimeFromTimestamp(int? timestamp) {
  return timestamp == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(timestamp);
}

int? timestampFromDateTimeFromTimestamp(DateTime? date) {
  return date?.millisecond;
}
