import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grey_pile_of_shame/database/repository/paint_status_repository.dart';
import 'package:grey_pile_of_shame/l10n/app_localizations.dart';
import 'package:grey_pile_of_shame/models/paint_status.dart';

class PaintingStatusSettingsScreen extends StatefulWidget {
  const PaintingStatusSettingsScreen({super.key});

  @override
  State<PaintingStatusSettingsScreen> createState() =>
      _PaintingStatusSettingsScreenState();
}

class _PaintingStatusSettingsScreenState
    extends State<PaintingStatusSettingsScreen> {
  final paintRepo = PaintingStatusRepository();
  List<PaintingStatus> statuses = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    final data = await paintRepo.getAll();
    setState(() {
      statuses = data;
      loading = false;
    });
  }

  bool _isFixed(PaintingStatus status) {
    // Cambiar según tus nombres exactos
    return status.name.toLowerCase() == 'sin montar' ||
        status.name.toLowerCase() == 'terminado';
  }

  void _addOrEditStatus([PaintingStatus? status]) {
    String name = status?.name ?? '';
    Color color = status != null
        ? Color(int.parse('FF${status.color.replaceFirst('#', '')}', radix: 16))
        : Colors.grey;
    int orden = status?.orden ?? (statuses.length + 1);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            status == null
                ? AppLocalizations.of(context)!.newPaintingStatus
                : AppLocalizations.of(context)!.editPaintingStatus,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.statusNameLabel,
                ),
                controller: TextEditingController(text: name),
                onChanged: (v) => name = v,
                enabled: !_isFixed(
                  status ?? PaintingStatus(name: '', orden: 0, color: 'black'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.statusColorLabel),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      Color picked = color;
                      await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Select Color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: color,
                              onColorChanged: (c) => picked = c,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() => color = picked);
                              },
                              child: const Text('Select'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.statusOrderLabel),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (orden > 1) setState(() => orden--);
                    },
                  ),
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(
                      orden.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => orden++),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                if (name.trim().isEmpty) return;
                final ps = PaintingStatus(
                  id: status?.id,
                  name: name.trim(),
                  color:
                      '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                  orden: orden,
                );
                if (status == null) {
                  await paintRepo.insert(ps);
                } else {
                  await paintRepo.update(ps);
                }
                await _loadStatuses();
                Navigator.pop(context);
              },
              child: Text(
                status == null
                    ? AppLocalizations.of(context)!.add
                    : AppLocalizations.of(context)!.save,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteStatus(PaintingStatus status) {
    if (_isFixed(status)) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deletePaintingStatusTitle),
        content: Text(
          AppLocalizations.of(
            context,
          )!.deletePaintingStatusContent(status.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              await paintRepo.delete(status.id!);
              await _loadStatuses();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.paintingStatusSettingsTitle),
      ),
      body: ListView(
        children: [
          ...statuses.map(
            (status) => ListTile(
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(
                    int.parse(
                      'FF${status.color.replaceFirst('#', '')}',
                      radix: 16,
                    ),
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status.name),
                  Text(
                    '${AppLocalizations.of(context)!.statusOrderLabel}: ${status.orden}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _isFixed(status)
                        ? null
                        : () => _addOrEditStatus(status),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: _isFixed(status)
                        ? null
                        : () => _deleteStatus(status),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(AppLocalizations.of(context)!.newPaintingStatus),
            onTap: () => _addOrEditStatus(),
          ),
        ],
      ),
    );
  }
}
