import 'package:faker/faker.dart';

class Feed {
  List<String> photos;
  String caption;
  String username;

  Feed({required this.photos, required this.caption, required this.username});
}

var faker = Faker();

var postFeeds = [
  Feed(
      photos: [
        "https://picsum.photos/id/237/500/500",
        "https://picsum.photos/id/238/500/500",
        "https://picsum.photos/id/239/500/500"
      ],
      caption: faker.lorem.sentence(),
      username: faker.internet.userName()
  ),
  Feed(
      photos: [
        "https://picsum.photos/id/240/500/500",
        "https://picsum.photos/id/241/500/500",
        "https://picsum.photos/id/242/500/500"
      ],
      caption: faker.lorem.sentence(),
      username: faker.internet.userName()
  ),
  Feed(
      photos: [
        "https://picsum.photos/id/243/500/500",
        "https://picsum.photos/id/244/500/500",
        "https://picsum.photos/id/246/500/500"
      ],
      caption: faker.lorem.sentence(),
      username: faker.internet.userName()
  )
];
