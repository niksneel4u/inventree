
import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['product_link', 'setRate']
  connect() {

  }
  set_data(event) {
    getproductdetail(this.product_linkTarget.value);
  }
}

function getproductdetail(product_link) {
  $.ajax({
    type: "GET",
    url: 'homes/getproductdetail',
    dataType: 'script',
    data: {
      product_link: product_link
    },
    success: function (data) {
      debugger;
    }
  })
}