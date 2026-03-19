import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/dao/army_dao.dart';
import 'package:grey_pile_of_shame/database/dao/parametric_dao.dart';
import 'package:grey_pile_of_shame/database/repository/unit_repository.dart';
import 'package:grey_pile_of_shame/models/unit.dart';
import 'package:grey_pile_of_shame/models/army.dart';

class UnitEditScreen extends StatefulWidget {
  final Unit? unit;
  final int? armyId;

  const UnitEditScreen({super.key, this.unit, this.armyId});

  @override
  _UnitEditScreenState createState() => _UnitEditScreenState();
}

class _UnitEditScreenState extends State<UnitEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pointsController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  Army? selectedArmy;
  int? selectedRoleId;
  int? selectedPaintingStatusId;
  int paintingDifficulty = 1;
  DateTime? finishedAt;
  DateTime? purchasedAt;

  List<Army> armies = [];
  List<Map<String, dynamic>> roles = [];
  List<Map<String, dynamic>> paintingStatuses = [];

  bool isLoading = true;

  final armyDao = ArmyDao();
  final paramDao = ParametricDao();
  final unitRepository = UnitRepository();

  @override
  void initState() {
    super.initState();
    _initScreen();
  }

  Future<void> _initScreen() async {
    // Cargar ejércitos
    armies = await armyDao.getAllArmies();

    // Cargar roles y estados de pintado
    roles = await paramDao.getRoles();
    paintingStatuses = await paramDao.getPaintingStatuses();

    // Si editando, precargar datos
    if (widget.unit != null) {
      final u = widget.unit!;
      _nameController.text = u.name;
      _pointsController.text = u.points.toString();
      _priceController.text = (u.price ?? 0.0).toStringAsFixed(2);
      _notesController.text = u.notes ?? '';
      paintingDifficulty = u.paintingDifficulty;
      selectedRoleId = u.roleId;
      selectedPaintingStatusId = u.paintingStatusId;
      finishedAt = u.finishedAt;
      purchasedAt = u.purchasedAt;

      selectedArmy = armies.firstWhere(
        (a) => a.id == u.armyId,
        orElse: () => armies.first,
      );
    } else if (widget.armyId != null) {
      selectedArmy = armies.firstWhere(
        (a) => a.id == widget.armyId,
        orElse: () => armies.first,
      );
      selectedPaintingStatusId = paintingStatuses.first['id'];
    } else {
      selectedArmy = armies.isNotEmpty ? armies.first : null;
      selectedPaintingStatusId = paintingStatuses.isNotEmpty
          ? paintingStatuses.first['id']
          : null;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isFinished) async {
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isFinished
          ? (finishedAt ?? initialDate)
          : (purchasedAt ?? initialDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFinished) {
          finishedAt = picked;
        } else {
          purchasedAt = picked;
        }
      });
    }
  }

  void _saveUnit() async {
    if (!_formKey.currentState!.validate() || selectedArmy == null) return;

    final unitMap = {
      'name': _nameController.text.trim(),
      'army_id': selectedArmy!.id,
      'role_id': selectedRoleId,
      'points': int.tryParse(_pointsController.text) ?? 0,
      'price': double.tryParse(_priceController.text) ?? 0.0,
      'painting_status_id': selectedPaintingStatusId,
      'painting_difficulty': paintingDifficulty,
      'finished_at': finishedAt?.toIso8601String(),
      'purchased_at': purchasedAt?.toIso8601String(),
      'notes': _notesController.text.trim(),
    };

    if (widget.unit == null) {
      await unitRepository.insertUnit(unitMap);
      Navigator.pop(context, {
        'action': 'created',
        'name': _nameController.text.trim(),
      });
    } else {
      await unitRepository.updateUnit(widget.unit!.id!, unitMap);
      Navigator.pop(context, {
        'action': 'updated',
        'name': _nameController.text.trim(),
      });
    }
  }

  void _deleteUnit() async {
    if (widget.unit == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar unidad'),
        content: Text('¿Seguro que quieres borrar "${widget.unit!.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm ?? false) {
      await unitRepository.deleteUnit(widget.unit!.id!);

      Navigator.pop(context, {'action': 'deleted', 'name': widget.unit!.name});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit == null ? 'Nueva Unidad' : 'Editar Unidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Nombre obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Número de Miniaturas'),
              ),
              const SizedBox(height: 16),

              // Ejército
              DropdownButtonFormField<Army>(
                value: selectedArmy,
                decoration: const InputDecoration(labelText: 'Ejército'),
                items: armies
                    .map((a) => DropdownMenuItem(value: a, child: Text(a.name)))
                    .toList(),
                onChanged: (value) => setState(() => selectedArmy = value),
              ),
              const SizedBox(height: 16),

              // Rol de batalla
              DropdownButtonFormField<int>(
                value: selectedRoleId,
                decoration: const InputDecoration(labelText: 'Rol de batalla'),
                items: roles
                    .map(
                      (r) => DropdownMenuItem(
                        value: r['id'] as int,
                        child: Text(r['name']),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => selectedRoleId = v),
              ),
              const SizedBox(height: 16),

              // Puntos
              TextFormField(
                controller: _pointsController,
                decoration: const InputDecoration(labelText: 'Puntos'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Precio
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio (€)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),

              // Estado de pintado
              DropdownButtonFormField<int>(
                value: selectedPaintingStatusId,
                decoration: const InputDecoration(
                  labelText: 'Estado de pintado',
                ),
                items: paintingStatuses
                    .map(
                      (r) => DropdownMenuItem(
                        value: r['id'] as int,
                        child: Text(r['name']),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => selectedPaintingStatusId = v),
              ),
              const SizedBox(height: 16),

              // Complejidad de pintado
              Row(
                children: [
                  const Text('Complejidad de pintado:'),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Slider(
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: '$paintingDifficulty',
                      value: paintingDifficulty.toDouble(),
                      onChanged: (v) =>
                          setState(() => paintingDifficulty = v.toInt()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Fecha de compra
              Row(
                children: [
                  const Text('Fecha de compra: '),
                  Text(
                    purchasedAt != null
                        ? '${purchasedAt!.day}/${purchasedAt!.month}/${purchasedAt!.year}'
                        : 'No seleccionada',
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Fecha de finalización
              Row(
                children: [
                  const Text('Fecha de finalización: '),
                  Text(
                    finishedAt != null
                        ? '${finishedAt!.day}/${finishedAt!.month}/${finishedAt!.year}'
                        : 'No seleccionada',
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Observaciones
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Guardar
              ElevatedButton(
                onPressed: _saveUnit,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.unit != null
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: _deleteUnit,
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }
}
