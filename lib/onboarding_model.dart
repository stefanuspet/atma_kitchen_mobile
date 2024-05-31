class OnboardingModel {
  String image;
  String title;
  String discription;

  OnboardingModel(
      {required this.image, required this.title, required this.discription});
}

List<OnboardingModel> contents = [
  OnboardingModel(
    title: 'Atma Kitchen',
    image: 'assets/images/splash.png',
    discription:
        'Atma Kitchen adalah sebuah usaha baru di bidang kuliner, yang dimiliki oleh Bu Margareth Atma Negara, seorang selebgram yang sangat suka mencoba makanan yang sedang hits. Karena hobinya tersebut, Bu Margareth terinspirasi untuk membuat usaha di bidang kuliner, dimana ia akan menjual aneka kue premium, dan akan segera dibuka di Yogyakarta. ',
  ),
  OnboardingModel(
      title: 'Keunikan Kami',
      image: 'assets/images/hat.png',
      discription: "Atma Kitchen Menyajikan "
          "#Cake & sajian lezat untuk semua kalangan. "
          "Sejuta rasa untuk #BerbagiSemangat Bukan #TokoCake biasa Mampir & jadi #SahabatSejatiku"),
  OnboardingModel(
      title: 'Lokasi',
      image: 'assets/images/location.png',
      discription:
          "Atma Kitchen Berlokasi di Jl. Caturtunggal No. 1, RT. 01 / RW. 01, Caturtunggal, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281, Indonesia"),
];
