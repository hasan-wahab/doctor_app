double getSessionProgress({
  required final totalSession,
  required final usedSession,
}) {
  if (double.parse(totalSession) == 0) return 0.0;

  final progress = double.parse(usedSession) / double.parse(totalSession);

  if (progress.isNaN || progress.isInfinite) return 0.0;

  return progress.clamp(0.0, 1.0);
}
