import 'package:storyapp/model/stories.dart';

class DummyData {
  static final dummyStories = Stories(
    error: false,
    message: "Stories fetched successfully",
    listStory: [
      ListStory(
        id: "1",
        name: "Juna Cilok",
        description: "Hello",
        photoUrl: "https://picsum.photos/200",
        createdAt: DateTime.now(),
        lat: 0,
        lon: 0,
      ),
      ListStory(
        id: "2",
        name: "Sigit Rendang",
        description: "Hello",
        photoUrl: "https://picsum.photos/200",
        createdAt: DateTime.now(),
        lat: 0,
        lon: 0,
      ),
      ListStory(
        id: "3",
        name: "Agus Lontong",
        description: "Hello",
        photoUrl: "https://picsum.photos/200",
        createdAt: DateTime.now(),
        lat: 0,
        lon: 0,
      ),
    ],
  );
}
