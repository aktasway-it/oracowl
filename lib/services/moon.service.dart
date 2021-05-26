class MoonService {
  static final MoonService _singleton = MoonService._internal();
  factory MoonService() => _singleton;
  MoonService._internal();

  final double _lunarCycle = 29.53058770576;
  final List _phases = [
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

  double getLunarPhasePercent() {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, 22);
    DateTime firstFullMoon = DateTime(2000, 1, 6, 18, 14);
    double timeDiff = (now.millisecondsSinceEpoch - firstFullMoon.millisecondsSinceEpoch) / 1000;
    double lunarSecs = this._lunarCycle * 60 * 60 * 24;
    double secondsInCurrentCycle = timeDiff % lunarSecs;
    double currentPhasePercent = secondsInCurrentCycle / lunarSecs;
    return currentPhasePercent;
  }

  double getLunarDay() {
    return this.getLunarPhasePercent() * this._lunarCycle;
  }

  int getLunarIllumination() {
    double phasePercent = this.getLunarPhasePercent();
    if (phasePercent <= 0.5) {
      return (phasePercent / 0.5 * 100).round();
    } else {
      return ((1 - phasePercent) / 0.5 * 100).round();
    }
  }

  String getLunarPhaseImage() {
    double lunarDay = this.getLunarDay();
    for (int i = 0; i < this._phases.length; i++) {
      if (lunarDay >= this._phases[i][1] && lunarDay <= this._phases[i][2]) {
        return 'assets/icons/moon/${this._phases[i][0]}.png';
      }
    }
    return '';
  }
}