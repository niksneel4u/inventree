import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var requestedMarketplaceRules = {
      'requested_marketplace[name]': {
        required: true,
        url: true
      },
    };

    var errorMessages = {
      'requested_marketplace[name]':{
        required: 'place enter URL'
      }
    };
    Inventree.form.validate_form(requestedMarketplaceRules, errorMessages, '#requested_marketplace');
  }
}
