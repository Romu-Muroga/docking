class Animation {

  constructor() {
  }

  sliderStart() {
    try {
      const slide = document.getElementById('slide_wrapp');      //スライダー親
      const slideItem = slide.querySelectorAll('.slide_item');   //スライド要素
      const totalNum = slideItem.length - 1;                     //スライドの枚数を取得
      const FadeTime = 2000;                                     //フェードインの時間
      const IntarvalTime = 7000;                                 //クロスフェードさせるまでの間隔
      let actNum = 0;                                            //現在アクティブな番号
      let nowSlide;                                              //現在表示中のスライド
      let NextSlide;                                             //次に表示するスライド

      // スライドの1枚目をフェードイン
      slideItem[0].classList.add('show_', 'zoom_');

      // 処理を繰り返す
      setInterval(() => {
          if (actNum < totalNum) {

              let nowSlide = slideItem[actNum];
              let NextSlide = slideItem[++actNum];

              //.show_削除でフェードアウト
              nowSlide.classList.remove('show_');
              // と同時に、次のスライドがズームしながらフェードインする
              NextSlide.classList.add('show_', 'zoom_');
              // 次のスライドがズームなし
              // NextSlide.classList.add('show_');
              //フェードアウト完了後、.zoom_削除
              setTimeout(() => {
                  nowSlide.classList.remove('zoom_');
              }, FadeTime);

          } else {

              let nowSlide = slideItem[actNum];
              let NextSlide = slideItem[actNum = 0];

              //.show_削除でフェードアウト
              nowSlide.classList.remove('show_');
              // と同時に、次のスライドがズームしながらフェードインする
              NextSlide.classList.add('show_', 'zoom_');
              //フェードアウト完了後、.zoom_削除
              setTimeout(() => {
                  nowSlide.classList.remove('zoom_');
              }, FadeTime);

          };
      }, IntarvalTime);
    } catch(e) {
      return
    }
  }
}


class Post {
  constructor(
    index_callback= () => {},
  ) {
    this.index_callback = index_callback;
    this.setPattern();
  }

  setPattern() {
    this.index_pattern = /categories\/\d+\/posts/
    this.show_pattern = /categories\/\d+\/posts\/\d+/
    // etc
  }

  run() {
    const url = window.location.pathname
    if (url.match(this.index_pattern)) {
      this.index_callback();
    } else {
      return
    }
  }
}

$(document).on("turbolinks:load", () => {
  const animation = new Animation()
  const post = new Post(animation.sliderStart())
  post.run()
});
