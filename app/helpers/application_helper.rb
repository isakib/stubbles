module ApplicationHelper
  def container_id_of(model)
    model.new_record? ? 'new' : "#{model.class.name.downcase}-#{model.id}"
  end

  def ajax_cancel_link(model, removeElement = 'form', options = {})
    if (!model.new_record?)
      link_to "cancel", {:action => "show"}, :remote => true, :'data-disable-with' => "canceling...", :class => "btn btn-default #{options[:class]}"
    else
      link_to "cancel", '#', :'data-cancel' => removeElement, :'data-disable-with' => "canceling...", :class => "btn btn-default #{options[:class]}"
    end
  end

  def deactivate_link(model, activate_path, deactivate_path)
    text = model.active? ? 'Deactivate' : 'Activate'
    path = model.active? ? deactivate_path : activate_path
    return link_to text, path, :confirm => 'Are you sure?', :method => :put, :remote => true
  end

  def render_error_message
    render :partial => 'shared/notification'
  end

  def execute_js_if(success)
    if success
      yield
      concat raw "Message.successMessage('#{escape_javascript(flash[:notice])}');"
    else
      concat raw render_error_message
    end
  end

  def avatar(user, size = 20)
    image_tag(user.gravatar_url(size), :size => "#{size}x#{size}", :alt => "Avatar")
  end

  def progress_bar_with_percent(percent)
    content_tag(:div, class: 'progress') do
      content_tag(:div, '', class: 'progress-bar', role: 'progressbar',
                  :'aria-valuenow' => "60", :'aria-valuemin' => "0",
                  :'aria-valuemax' => "100", style: "width: #{percent}%;")
    end
  end

  def progress_bar_for(model)
    progress_bar_with_percent(model.percent_completed)
  end
end