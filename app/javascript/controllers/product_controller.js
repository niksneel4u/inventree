
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

    if ($('.tabPagonation').length > 0){
      var one_time_call = 0;
      var more_posts_url = $('.tabPagonation a').attr('href');
      $(window).scroll(function(){
        if (one_time_call == 0 && more_posts_url && ($(window).scrollTop() > $(document).height() - $(window).height() - 60)){
          if ($('#page').length > 0){
            $('#loader').removeClass('hidden');
            setTimeout(
              function()
              {
                $('#page')[0].click();
              }, 1000
            );
          }
          one_time_call = 1;
        }
      });
    }
  }

  changeStatus(){
    $.ajax({
      type: "PATCH",
      url: '/products/' + $(event.target).val() + '/change_status',
      dataType: 'script'
    });
  }
}
