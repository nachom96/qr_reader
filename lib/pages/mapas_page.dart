import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

import '../providers/scans_list_provider.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'geo');
  }
}
