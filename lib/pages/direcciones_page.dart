import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scans_list_provider.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor,),
        title: Text(scans[i]!.valor),
        subtitle: Text(scans[i]!.id.toString()),
        trailing: Icon(Icons.home_outlined, color: Colors.grey,),
        onTap: () => print('Abrir algo'),
      )
    );
  }
}