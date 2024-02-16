import 'package:storyapp/provider/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class ListStoryScreen extends StatelessWidget {
  final Function(String) onTapped;
  final Function() onLogout;
  final Function() toAddStory;

  const ListStoryScreen({
    super.key,
    required this.onTapped,
    required this.onLogout,
    required this.toAddStory,
  });

  @override
  Widget build(BuildContext context) {
    final authProviderWatch = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story App"),
      ),
      body: Consumer<StoryProvider>(
        builder: (context, value, _) {
          if (value.isLoading) return const Center(child: CircularProgressIndicator());

          return ListView.builder(
            itemCount: value.result.listStory.length,
            itemBuilder: (context, index) {
              final story = value.result.listStory[index];
              return InkWell(
                onTap: () => onTapped(story.id),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 150,
                          child: Image.network(story.photoUrl, fit: BoxFit.fitWidth),
                        ),
                        const SizedBox(height: 8),
                        Text(story.name),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              toAddStory();
            },
            tooltip: "Add Story",
            child: authProviderWatch.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              final authProvider = context.read<AuthProvider>();
              await authProvider.logout();
              onLogout();
            },
            tooltip: "Logout",
            child: authProviderWatch.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
