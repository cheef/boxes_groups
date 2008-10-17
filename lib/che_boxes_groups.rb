module ActionView
  module Helpers
    class FormBuilder
      def radio_boolean_group(method, labels, options = {})
        html = @template.radio_button(@object_name, method, nil, options.merge(:object => @object).merge(:id => "#{@object_name}_#{method}_default"))
        html += @template.label(@object_name, "#{method}_default", labels[0], :object => @object)
        html += @template.radio_button(@object_name, method, "true", options.merge(:object => @object))
        html += @template.label(@object_name, "#{method}_true", labels[1], :object => @object)
        html += @template.radio_button(@object_name, method, "false", options.merge(:object => @object))
        html += @template.label(@object_name, "#{method}_false", labels[2], :object => @object)
      end
      
      def check_box_group(method, all_values, options = {})
        CheckboxGroupRenderer.new(@template, "#{@object_name}[#{method.to_s}]", @object.send("#{method.to_s}"), all_values, options.merge(:object => @object)).render
      end
    end
    
    module FormTagHelper      
      def check_box_group_tag(name, instance_values, all_values, options = {})        
        CheckboxGroupRenderer.new(self, name, instance_values, all_values, options).render
      end
    end  
  end
end