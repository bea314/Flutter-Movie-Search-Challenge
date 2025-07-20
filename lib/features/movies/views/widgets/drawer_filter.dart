import 'package:flutter/material.dart';

import '../../logic/enums/media_type.dart';

class FilterDrawer extends StatefulWidget {
  final List<MediaType> selectedTypes;
  final String? selectedYear;
  final void Function(List<MediaType> selectedTypes, String? year) onApply;

  const FilterDrawer({
    super.key,
    this.selectedTypes = const [],
    this.selectedYear,
    required this.onApply,
  });

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late List<MediaType> _selectedTypes;
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTypes = List.from(widget.selectedTypes);
    _yearController.text = widget.selectedYear ?? '';
  }

  void _toggleMediaType(MediaType type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.zero,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Filters',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Media Type',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 2),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        MediaType.values.map((type) {
                          final isSelected = _selectedTypes.contains(type);
                          return FilterChip(
                            label: Text(type.value),
                            selected: isSelected,
                            onSelected: (_) => _toggleMediaType(type),
                            selectedColor: Colors.deepPurple.shade200,
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Year',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 2),
                  TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'E.g. 2010',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      widget.onApply(
                        _selectedTypes,
                        _yearController.text.trim().isEmpty
                            ? null
                            : _yearController.text.trim(),
                      );
                      Navigator.pop(context); // Cierra el drawer
                    },
                    icon: Icon(Icons.filter_alt),
                    label: Text('Apply Filters'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(48),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
