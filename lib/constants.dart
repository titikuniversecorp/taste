

class Constants {
  static String getWaitTime(List<Duration>? waitTime) {
    String timeLabel = 'мин'; // TODO: Настроить: либо "мин", либо "ч" + локализация
    if (waitTime == null || waitTime.isEmpty) return "Моментально"; // 0 $timeLabel

    if (waitTime.length < 2) {
      return '${_printDuration(waitTime.first)} $timeLabel';
    } 
    else {
      return '${_printDuration(waitTime.first)}-${_printDuration(waitTime.last)} $timeLabel';
    }
  }

  static String _printDuration(Duration duration) {
    // String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = duration.inMinutes.remainder(60).toString();
    // String twoDigitSeconds = duration.inSeconds.remainder(60).toString();
    return twoDigitMinutes;
  }
}