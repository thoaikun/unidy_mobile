class PostEmotionalData {
  String imgUrl;
  String title;

  PostEmotionalData({
    required this.imgUrl,
    required this.title
  });
}

enum EPostEmotional {
  happy,
  excited,
  amazing,
  wonderful,
  admire,
  relax
}

Map<EPostEmotional, PostEmotionalData> ePostEmotionalMap = {
  EPostEmotional.happy: PostEmotionalData(
    imgUrl: 'assets/imgs/emotional_emoji/happy.png',
    title: 'Hạnh phúc'
  ),
  EPostEmotional.excited: PostEmotionalData(
    imgUrl: 'assets/imgs/emotional_emoji/excited.png',
    title: 'Hào hứng'
  ),
  EPostEmotional.amazing: PostEmotionalData(
    imgUrl: 'assets/imgs/emotional_emoji/amazing.png',
    title: 'Tuyệt vời'
  ),
  EPostEmotional.wonderful: PostEmotionalData(
    imgUrl: 'assets/imgs/emotional_emoji/wonderful.png',
    title: 'Tuyệt vời'
  ),
  EPostEmotional.admire: PostEmotionalData(
    imgUrl: 'assets/imgs/emotional_emoji/admire.png',
    title: 'Ngưỡng mộ'
  ),
  EPostEmotional.relax: PostEmotionalData(
    imgUrl: 'assets/imgs/emotional_emoji/relax.png',
    title: 'Thư giãn'
  )
};