import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../logic/enums/media_type.dart';

class FilterDrawer extends StatefulWidget {
  final List<MediaType> selectedTypes;
  final String? selectedYear;
  final void Function(List<MediaType> selectedTypes, String? year) onApply;
  final void Function() onSearch;

  const FilterDrawer({
    super.key,
    this.selectedTypes = const [],
    this.selectedYear,
    required this.onApply,
    required this.onSearch,
  });

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late List<MediaType> _selectedTypes;
  final TextEditingController _yearController = TextEditingController();
  bool _yearError = false;

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
        // Because the API does not support multiple types,
        // we clear the list and add the selected type
        _selectedTypes
          ..clear()
          ..add(type);
      }
    });
    widget.onApply(_selectedTypes, _yearController.text.trim().isEmpty ? null : _yearController.text.trim());
  }

  bool _isValidYear(String v) {
    if (v.isEmpty) return true;
    final y = int.tryParse(v);
    final current = DateTime.now().year;
    return y != null && y >= 1900 && y <= current;
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
                          if(type == MediaType.unknown) return const SizedBox.shrink();
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: InputDecoration(
                      hintText: 'E.g. 2010',
                      border: OutlineInputBorder(),
                      errorText: _yearError
                          ? 'Enter a valid year (1900-${DateTime.now().year})'
                          : null,
                    ),
                    onChanged: (value) {
                      final ok = _isValidYear(value.trim());
                      setState(() {
                        _yearError = !ok;
                      });
                      // Only apply if the year is valid or null
                      if (ok || value.trim().isEmpty) {
                        widget.onApply(
                          _selectedTypes,
                          value.trim().isEmpty ? null : value.trim(),
                        );
                      }
                    },
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
                      widget.onSearch();
                      Navigator.pop(context); // Cierra el drawer
                    },
                    icon: Icon(Icons.filter_alt),
                    label: Text('Search'),
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
