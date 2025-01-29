import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _PieData {
  _PieData(this.xData, this.yData, this.text, this.color);

  final String xData;
  final num yData;
  final String text;
  final Color color; // Add color property
}

class PieChartG extends StatelessWidget {
  final RxMap<String, double> coinPercentages;

  const PieChartG({super.key, required this.coinPercentages});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Color> colorPalette = [
        const Color(0xFFc5c6c5), // First color
        const Color(0xFF8a8b8b), // Second color
        Colors.white, // Third color
      ];

      final pieData = coinPercentages.entries.mapIndexed((index, entry) {
        return _PieData(
          entry.key,
          entry.value,
          '${entry.value.toStringAsFixed(2)}%',
          colorPalette[index % colorPalette.length], // Cycle through colors
        );
      }).toList();

      return SfCircularChart(
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: pieData,
            xValueMapper: (_PieData data, _) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            dataLabelMapper: (_PieData data, _) => data.text,
            pointColorMapper: (_PieData data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      );
    });
  }
}



extension MapIndexed<K, V> on Iterable<MapEntry<K, V>> {
  Iterable<T> mapIndexed<T>(T Function(int index, MapEntry<K, V> entry) f) sync* {
    var index = 0;
    for (var entry in this) {
      yield f(index++, entry);
    }
  }
}
