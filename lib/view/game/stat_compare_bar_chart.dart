import 'package:flutter/material.dart';

class StatHeadToHeadCompareChart extends StatefulWidget {
  String statName;
  int teamOneStatCount;
  int teamTwoStatCount;
  StatHeadToHeadCompareChart(
      {Key? key,
      required this.statName,
      required this.teamOneStatCount,
      required this.teamTwoStatCount})
      : super(key: key);

  @override
  State<StatHeadToHeadCompareChart> createState() =>
      _StatHeadToHeadCompareChartState();
}

class _StatHeadToHeadCompareChartState
    extends State<StatHeadToHeadCompareChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.teamOneStatCount.toString(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            // fontStyle: FontStyle.italic,
                            fontSize: 20)),
                    Text(widget.statName,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                            fontSize: 20)),
                    Text(widget.teamTwoStatCount.toString(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            // fontStyle: FontStyle.italic,
                            fontSize: 20)),
                  ],
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: widget.teamOneStatCount,
                        child: Container(
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 215, 0, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(25),
                              bottomRight: Radius.circular(0),
                              topLeft: const Radius.circular(25),
                              topRight: const Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: widget.teamTwoStatCount,
                        child: Container(
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 161, 16, 1),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: const Radius.circular(0),
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(0),
                              topRight: const Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
