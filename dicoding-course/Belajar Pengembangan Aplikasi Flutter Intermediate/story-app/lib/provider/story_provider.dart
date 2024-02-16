import 'package:storyapp/data/repositories/story_repository.dart';
import 'package:storyapp/model/response_default.dart';
import 'package:storyapp/model/stories.dart';
import 'package:storyapp/model/upload_story.dart';
import 'package:flutter/foundation.dart';

class StoryProvider extends ChangeNotifier {
  final StoryRepositories storyRepositories;

  StoryProvider({required this.storyRepositories}) {
    stories = Stories(error: false, message: "Init stories", listStory: []);
    _fetchStories();
  }

  late Stories stories;

  Stories get result => stories;

  void _fetchStories() {
    getStories();
  }

  bool isLoading = false;

  Future<ResponseDefault> createStory(UploadStory uploadStory) async {
    isLoading = true;
    notifyListeners();

    try {
      return await storyRepositories.createStory(uploadStory);
    } catch (e) {
      return ResponseDefault(
        error: true,
        message: e.toString(),
      );
    } finally {
      getStories();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Stories> getStories() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await storyRepositories.getStories();
      if (response.listStory.isEmpty) {
        return stories = Stories(
          error: false,
          message: "Stories is empty!",
          listStory: [],
        );
      } else {
        return stories = response;
      }
    } catch (e) {
      return stories = Stories(
        error: true,
        message: e.toString(),
        listStory: [],
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
