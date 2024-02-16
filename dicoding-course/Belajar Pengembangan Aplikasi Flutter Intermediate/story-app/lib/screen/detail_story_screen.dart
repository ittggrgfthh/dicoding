import 'package:storyapp/provider/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailStoryScreen extends StatelessWidget {
  final String storyId;
  final Function() onPopScreen;

  const DetailStoryScreen({
    super.key,
    required this.storyId,
    required this.onPopScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, value, _) {
        final story = value.result.listStory.singleWhere((element) => element.id == storyId);
        return Scaffold(
          appBar: AppBar(
              title: Text(story.name),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => onPopScreen(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(story.photoUrl, fit: BoxFit.fitWidth, width: double.infinity),
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 2,
                  child: Text(story.description, style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
