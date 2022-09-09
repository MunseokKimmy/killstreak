class StatInfoLiteral {
  static const map = {
    'ace':
        'A serve that directly leads to a point. Ex. Hits opposing court untouched, contact is made but ball is not kept in play, or violation on receiving team.',
    'service_errors':
        'A serve that directly results in a point for the opposing team. Ex. Ball does not go over the net, out of bounds, foot faults, etc.',
    'kills':
        'An kill is considered to be a strategic hit by a player that directly leads to a point.',
    'attack_errors':
        'An attack that directly results in a point for the opposing team. Ex. Ball hit out of bounds, into the net, four-hit violation, or blocked.',
    'assists':
        'An assist is when a player passes, sets or digs ball to teammate who gets a kill. ',
    'ball_handling_errors':
        'An assist attempt that results in an error. Ex. Double hit, thrown ball, lifted ball. If it goes over the net and out of bounds, it is an attack error.',
    'blocks':
        'A block is when a player blocks a ball, immediately leading to a point. If the ball is kept in play, no block is recorded.',
    'block_errors':
        'When a player\'s attempt to block a ball results in an error. Ex. Blocker in the net, across center line, reaches over net. If a player stuffs an overpass, it is a kill, not a block.',
    'digs':
        'A dig is when a player receives an attacked ball and keeps the ball in play. Remember, free balls and serves are not attacked balls.',
    'reception_errors':
        'A serve reception that results in an error or the ball is not kept in play. Only for receiving serves, not attacks.',
  };

  getInfo(String statType) {
    String? typeInfo = map[statType];
    return typeInfo;
  }
}
