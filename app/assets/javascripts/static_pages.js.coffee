# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 
  $('button.add_choice_button').click (event) =>
    button = $('button.add_choice_button')
    
    # find choices div
    choices = $('div#choices')

    # add additional answer choice
    new_choice_id = choices.children('div.field').size()
    new_choice = 
      "<div class=\"field\">
        <textarea id=\"question_responses_attributes_#{new_choice_id}_content\" name=\"question[responses_attributes][#{new_choice_id}][content]\" placeholder=\"Enter choice...\"></textarea>
      </div>"
    choices.append(new_choice)

  $('button.delete_choice_button').click (event) =>
    button = $('button.delete_choice_button')

    # find choices div
    choices = $('div#choices')

    # remove last answer choice
    choices.children().last().remove()

