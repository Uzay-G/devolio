function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          let image_avatar = $("img.avatar");
          if (image_avatar.length > 0) {
            image_avatar.attr("src", e.target.result);
            image_avatar.addClass("local-avatar")
          } else {
            $("svg.avatar").replaceWith(
              $("<img/>", {
                "src": e.target.result,
                "class": "avatar local-avatar",
                "css": {
                  "width": "100",
                  "height": "100",
                  "border-radius": "125"
                }
              })
          )}
        }
        reader.readAsDataURL(input.files[0]);
    }
  }
  
  $(".random").click(function() {
    $("#user_avatar").click();
  })
  
  $("#user_avatar").change(function() {
    readURL(this);
  })
  
  $("#user_github").change(function() {
    if ($("img.local-avatar").length == 0) {
      if ($(".avatar").length > 0) {
        replaceWithGithub($(".avatar"));
      }  
    }
  })
  
  function replaceWithGithub(img) {
    img.replaceWith(
      $("<img/>", {
        src: "https://github.com/" +  $("#user_github").val() + ".png",
        class: "avatar",
        width: "100",
        height: "100"
      }))
  }