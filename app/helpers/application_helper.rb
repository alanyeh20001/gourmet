module ApplicationHelper
  def notice_message
		# receive the parameter from controller & covert it to symbol that bootstrap can recognize
		alert_types = { notice: :info, alert: :danger }
		
		# add a close button 'x' and make it dismissable
		close_button = content_tag(:button, "x", class: "close", "data-dismiss" => "alert", "aria-hidden" => true)
		
		# combine the alert message with close button to form the flash message
		alerts = flash.map do |type, message|
			alert_content =  close_button + message
			
			alert_type = alert_types[type.to_sym]
			#alert_type = type
			
			content_tag(:div, alert_content, class: "alert alert-#{alert_type} alert-dismissable")
		end
		
		alerts.join("\n").html_safe
	end
end
