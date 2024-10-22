enum TempType { C, F }

class Temp {
  static TempType tempType = TempType.C;
  static String get tempText {
    return tempType == TempType.C ? "C°" : "F°";
  }
}
