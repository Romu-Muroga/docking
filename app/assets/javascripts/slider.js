class Animation {

  // constructor() {
  //   this.slide_clear = false
  // }
  //
  // clearSlideAnimation() {
  //   this.slide_clear = true
  // }

  // sliderStart() {
  sliderStart(true_or_false) {
    try {
      // this.slide_clear = false
      const slide = document.getElementById('slide_wrapp');      //スライダー親
      const slideItem = slide.querySelectorAll('.slide_item');   //スライド要素
      const totalNum = slideItem.length - 1;                     //スライドの枚数を取得
      const FadeTime = 2000;                                     //フェードインの時間
      const IntarvalTime = 5000;                                 //クロスフェードさせるまでの間隔
      let actNum = 0;                                            //現在アクティブな番号
      let nowSlide;                                              //現在表示中のスライド
      let NextSlide;                                             //次に表示するスライド

      // スライドの1枚目をフェードイン
      slideItem[0].classList.add('show_', 'zoom_');

      // 処理を繰り返す
      setInterval(() => {
          // if (this.slide_clear) return;
          // console.log("ループしている")
          if (!(true_or_false)) return;
          console.log(true_or_false)

          if (actNum < totalNum) {

              let nowSlide = slideItem[actNum];
              let NextSlide = slideItem[++actNum];

              //.show_削除でフェードアウト
              nowSlide.classList.remove('show_');
              // と同時に、次のスライドがズームしながらフェードインする
              NextSlide.classList.add('show_', 'zoom_');
              // 次のスライドがズームなしでフェードイン
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

class Slider {
  // constructor(index_callback = () => {}, other_callback = () => {}) {
  constructor(index_callback = () => {}) {
    this.index_callback = index_callback;
    // this.other_callback = other_callback;
    this.setPattern();
  }

  setPattern() {
    this.index_pattern = /posts$/  //末尾にマッチ
    this.category_pattern = /categories\/\d+\/posts/
    // etc
  }

  run() {
    const url = window.location.pathname
    if (url.match(this.index_pattern) || url.match(this.category_pattern)) {
      // this.index_callback();
      this.index_callback(true);
      console.log("matchしている！！")
    } else {
      // this.other_callback();
      this.index_callback(false);
      console.log("matchしていない...")
    }
  }
}

// ターボリンクのロードが終わってから発動する
$(document).on("turbolinks:load", () => {
  const animation = new Animation()
  // const post = new Slider(animation.sliderStart, animation.clearSlideAnimation)
  const post = new Slider(animation.sliderStart)
  post.run()
});
