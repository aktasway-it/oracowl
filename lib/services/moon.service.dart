class MoonService {
  static const double _LUNAR_CYCLE = 29.53058770576;

  static const List phases = [
    ['new', 0, 1],
    ['waxing_crescent', 1, 6.38264692644],
    ['first_quarter', 6.38264692644, 8.38264692644],
    ['waxing_gibbous', 8.38264692644, 13.76529385288],
    ['full', 13.76529385288, 15.76529385288],
    ['waning_gibbous', 15.76529385288, 21.14794077932],
    ['last_quarter', 21.14794077932, 23.14794077932],
    ['waning_crescent', 23.14794077932, 28.53058770576],
    ['new', 28.53058770576, 29.53058770576],
  ];

  static double getLunarPhasePercent() {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, 22);
    DateTime firstFullMoon = DateTime(2000, 1, 6, 18, 14);
    double timeDiff = (now.millisecondsSinceEpoch - firstFullMoon.millisecondsSinceEpoch) / 1000;
    double lunarSecs = _LUNAR_CYCLE * 60 * 60 * 24;
    double secondsInCurrentCycle = timeDiff % lunarSecs;
    double currentPhasePercent = secondsInCurrentCycle / lunarSecs;
    double currentPhase = currentPhasePercent * _LUNAR_CYCLE;
    return currentPhasePercent;
  }

  static double getLunarDay() {
    return getLunarPhasePercent() * _LUNAR_CYCLE;
  }

  static int getLunarIllumination() {
    double phasePercent = getLunarPhasePercent();
    if (phasePercent <= 0.5) {
      return (phasePercent / 0.5 * 100).round();
    } else {
      return ((1 - phasePercent) / 0.5 * 100).round();
    }
  }

  static String getLunarPhaseImage() {
    double lunarDay = getLunarDay();
    print(getLunarIllumination());
    for (int i = 0; i < phases.length; i++) {
      if (lunarDay >= phases[i][1] && lunarDay <= phases[i][2]) {
        return 'assets/icons/moon/${phases[i][0]}.png';
      }
    }
    return '';
  }
}