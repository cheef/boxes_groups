class CheckboxGroupRenderer  
          
  def initialize(template, name, instance_values, available_values, options)
    @template, @name, @options = template, name, options
    @available_values, @instance_values = available_values, instance_values
    @current_id = 0
  end

  def render
    @available_values.map{|label_title, value| checkbox(value) + label(label_title)}.join separator
  end

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end

  private

    def label(label_title)
      @options[:labels] ||= {}
      content_tag(:label, @options[:labels].merge(:for => id(false))){label_title}
    end

    def checkbox(value)
      @options[:checkboxes] ||= {}
      check_box_tag @name, value, checked?(value), @options[:checkboxes].merge({:id => id, :name => "#{@name}[]"})
    end

    def id(counting = true)
      @current_id += 1 if counting
      @name.gsub(/\[/, "_").gsub(/\]/, "_") + @current_id.to_s                       
    end

    def separator
      @options[:separator].blank? ? "" : @options[:separator]
    end

    def checked?(value)
      @instance_values.include?(value)
    end
end