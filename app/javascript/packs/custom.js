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
  });

  $(document).on("click", ".update-quantity .plus", function(e) {
    let parent_obj = $(this).parents(".update-quantity");
    let input = parent_obj.find("input.quantity");
    let current_quantity = input.val();
    let product_quantity = input.data("quantity");

    current_quantity ++;
    if (product_quantity > current_quantity) {
      input.val(current_quantity);
      input.change();
    }else{
      check_quantity_product(product_quantity, current_quantity, input);
    }
  });

  $(document).on("click", ".update-quantity .minus", function(e) {
    let parent_obj = $(this).parents(".update-quantity");
    let input = parent_obj.find("input.quantity");
    let current_quantity = input.val();

    if (current_quantity > 1) {
      current_quantity--;
      input.val(current_quantity);
      input.change();
    }
  });

  $(document).on("change", ".update-quantity input.quantity", function(e) {
    let product_detail_id = $(this).data("id");
    let quantity = $(this).val();
    let product_quantity = $(this).data("quantity");

    check_quantity_product(product_quantity, quantity, $(this));
    $.ajax({
      method: "POST",
      url: "/update_cart",
      data: {product_detail_id: product_detail_id, quantity: quantity},
      dataType: 'script'
    });
  });
});

function check_quantity_product(pro_quantity, quantity, obj) {
  if (quantity > 99) {
    obj.val("1")
    alert(I18n.t("not_more_pro"));
    return;
  }
  if (quantity > pro_quantity) {
    obj.val("1")
    alert(I18n.t("not_enough_product"));
    return;
  }
}

function sendSelectOptionCart(product_size_id, product_color_id, product_id) {
  $.ajax({
    method: "POST",
    url: "/select_option_cart",
    data: {product_size_id: product_size_id, product_color_id: product_color_id, product_id: product_id},
    dataType: 'script'
  });
}
