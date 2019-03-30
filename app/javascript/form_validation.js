Inventree.form = {
  validate_form: function(rules, errorMessages, form_element) {
    $(form_element).validate({
      errorClass: 'invalid-error animated fadeInDown',
      errorElement: 'li',
      rules: rules,
      messages: errorMessages
    });
  }
};
