const pay = () => {
  const saveCard = document.getElementById("save_card")
  if (document.getElementById("save_card")){
    return saveCard;
  };
  const cardForm = document.querySelector(".Cardpage");
  // クレジット登録ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!cardForm) return null;
  console.log("card_user.jsが読み込まれました");

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // 環境変数を読み込む
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => { // イベント発火
    e.preventDefault();
    // カード情報の取得先
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = { // カードオブジェクトを生成
      number: formData.get("number"),              // カード番号
      cvc: formData.get("cvc"),                    // カード裏面の3桁の数字
      exp_month: formData.get("exp_month"),        // 有効期限の月
      exp_year: `20${formData.get("exp_year")}`,   // 有効期限の年
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        console.log(token)
        const renderDom = document.getElementById("charge-form");   //idを元に要素を取得
        const tokenObj = `<input value=${token} name='card_token' type="hidden">`;   //paramsの中にトークンを含める
        renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームの一番最後に要素を追加
      }

      document.getElementById("number").removeAttribute("name");
      document.getElementById("cvc").removeAttribute("name");
      document.getElementById("exp_month").removeAttribute("name");
      document.getElementById("exp_year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};
window.addEventListener("load", pay);