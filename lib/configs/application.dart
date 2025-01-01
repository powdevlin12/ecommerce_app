class Application {
  static const bool supportOTP = true;
  static const bool useHTMLWidgetForAllContent = true;
  static const bool useMarkdownForHTMLLargeContent = true;
  static const bool useMarkdownForHTMLSmallContent = true;
  static const dateFormat = 'yyyy/DD/mm';
  static bool localTimeZone = false;
  static bool debug = false;
  static String versionIntro =
      '0.0.1'; // Change this version if application have new function and would like to introduce
  static bool useShimmerLoading = true;

  // static UserInfo userInfo = UserInfo.empty();

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
