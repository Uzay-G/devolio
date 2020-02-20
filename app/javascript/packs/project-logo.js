$(".project-logo-div").click(function() {
    $("#project_logo").click()
})
function readURL(input) {
  if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        if ($("img.project-logo").length > 0) {
          $("img.project-logo").attr("src", e.target.result)
        } else {
          $(".project-identicon").replaceWith(
            $("<img/>", {
              "src": e.target.result,
              "css": {
                "width": "100",
                "height": "100",
              }
            })
        )}
      }
      reader.readAsDataURL(input.files[0]);
  }
}

$("#project_logo").change(function() {
  readURL(this);
})