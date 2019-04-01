
import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['product_link', 'setRate', 'setMarketPlace']
  connect() {

  }
  set_data(event) {
    getproductdetail(this.product_linkTarget.value, this.setRateTarget, this.setMarketPlaceTarget);
  }
}

function getproductdetail(product_link, setRateTarget, setMarketPlaceTarget) {
  $.ajax({
    type: "GET",
    url: $('#getdata').val(),
    dataType: 'script',
    data: {
      product_link: product_link
    },
    success: function (data) {
      setRateTarget.textContent = JSON.parse(data).data.price;
      setMarketPlaceTarget.textContent = JSON.parse(data).data.marketplace
    }
  })
}