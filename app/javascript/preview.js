document.addEventListener('DOMContentLoaded', function(){
  // 新規投稿・編集ページのフォームを取得
  const postForm = document.getElementById('new_item_image');
  const previewList = document.getElementById('previews')
  // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!postForm) return null;
  console.log("preview.jsが読み込まれました");

  const fileField = document.querySelector('input[type="file"][name="item[image]"]');
  fileField.addEventListener('change', function(e){
    // 古いプレビューが存在する場合は削除
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');

    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);

    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  });
});