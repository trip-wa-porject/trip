class LevelFormatUtils {
  static String getLevelStringTemplate(String level) {
    String levelTemplate;
    switch (level) {
      case 'B':
      case 'BK':
        levelTemplate = '健腳山友(中級)';
        break;
      case 'C':
      case 'CK':
        levelTemplate = '艱難路線(進階)';
        break;
      case 'AK':
      default:
        levelTemplate = '大眾路線(入門)';
    }
    return levelTemplate;
  }
}
