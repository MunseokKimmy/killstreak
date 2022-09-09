class StatInfoLiteral {
  static const map = {
    'ace': '',
    'service_errors': '',
    'kills': '',
    'attack_errors': '',
    'assists': '',
    'ball_handling_errors': '',
    'blocks': '',
    'block_errors': '',
    'digs': '',
    'reception_errors': '',
  };

  getInfo(String statType) {
    String? typeInfo = map[statType];
    return typeInfo;
  }
}
