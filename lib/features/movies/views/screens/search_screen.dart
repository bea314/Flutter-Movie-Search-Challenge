import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Search by movie title',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) {
                          // TODO: call search action
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.display_settings),
                      onPressed: () {
                        // TODO: call search action
                      },
                    ),
                    const SizedBox(width: 2),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // TODO: call search action
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.0),
              TextButton(
                onPressed: () {
                  // TODO: call search action
                },
                child: Text('Search Random Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
