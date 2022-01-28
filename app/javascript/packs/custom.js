$( document ).ready(function() {
  $('.flexslider').flexslider({
    animation: "slide",
    controlNav: "thumbnails"
  });

  $(document).on("change", "select#product_size_id", function() {
    sendSelectOptionCart($(this).val(),
                        $("select#product_color_id").val(),
                        $(".select_option").data("product_id"));
  });

  $(document).on("change", "select#product_color_id", function() {
    sendSelectOptionCart($("select#product_size_id").val(),
                        $(this).val(),
                        $(".select_option").data("product_id"));
  })
});

function sendSelectOptionCart(product_size_id, product_color_id, product_id) {
   $.post("/select_option_cart",
        {product_size_id: product_size_id,
        product_color_id: product_color_id,
        product_id: product_id},
  function(res) {
    if (res.cart_params != null) {
      $(".quantity_product").text(res.cart_params.quantity)
      $(".add_to_cart #product_detail_id").val(res.cart_params.id)
      $("input.add_cart").attr("disabled", false)
    }else {
      $(".quantity_product").text("No product")
      $("input.add_cart").attr("disabled", true)
    }
  });
}
