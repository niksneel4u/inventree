
import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var signInRules = {
      'product[product_url]': {
        required: true,
        url: true
      }
    };

    var errorMessages = {
      'product[product_url]': {
        required: 'Place Enter Marketplace',
        url: 'Place Enter Valid Marketplace'
      }
    };
    Inventree.form.validate_form(signInRules, errorMessages, '#product');
  }
}
