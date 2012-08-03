module NestedFieldsRails
  class ::ActionView::Helpers::FormBuilder

    def link_to_add_nested_fields(*args, &block)
      options = args.extract_options!.symbolize_keys
      association = args.pop
      options[:class] = [options[:class], 'add-nested-fields'].compact.join(' ')
      options['data-association'] = association
      args << (options.delete(:href) || 'javascript:void(0)')
      args << options
      @template.link_to(*args, &block)
    end

    def link_to_remove_nested_fields(*args, &block)
      (hidden_field(:_destroy, :class => 'destroy') << link_to_action_nested_fields(:remove, *args, &block)).html_safe
    end

    def link_to_up_nested_fields(*args, &block)
      link_to_action_nested_fields(:up, *args, &block)
    end

    def link_to_down_nested_fields(*args, &block)
      link_to_action_nested_fields(:down, *args, &block)
    end

    def index_nested_fields(attribute_name)
      hidden_field attribute_name, :class => 'index'
    end

    def nested_fields_for(association_name, record_object = nil, fields_options = {}, &block)
      collection_wrapper = fields_options[:collection_wrapper] || (fields_options[:wrapper] && fields_options[:wrapper].to_sym == :table ? :tbody : nil) || :div
      element_wrapper = fields_options[:element_wrapper] || (fields_options[:wrapper] && fields_options[:wrapper].to_sym == :table ? :tr : nil) || :div

      fields_block = block || Proc.new { |fields| @template.render(:partial => "#{association_name.to_s.singularize}_fields", :locals => {:f => fields}) }
      fields = @template.content_tag(collection_wrapper, fields_for(association_name, record_object, fields_options, &fields_block), :id => association_name, :class => 'nested-fields')

      model_object = object.class.reflect_on_association(association_name).klass.new
      template = fields_for(association_name, model_object, :element_wrapper => element_wrapper, :child_index => "new_#{association_name}", &fields_block)
      template_options = {:id => "#{association_name}_fields_template", :type => 'text/x-jquery-tmpl'}
      fields_template = @template.content_tag(:script, template, template_options)

      fields + fields_template
    end

    alias default_fields_for_nested_model fields_for_nested_model
    def fields_for_nested_model(name, object, options, block)
      tag = options[:element_wrapper] || (options[:wrapper] && options[:wrapper].to_sym == :table ? :tr : nil) || :div
      html_attributes = {
        :class => 'fields', 
        'data-object-id' => options[:child_index] || object.object_id, 
        :style => object._destroy ? 'display: none;' : ''
      }
      @template.content_tag(tag, default_fields_for_nested_model(name, object, options, block), html_attributes)
    end

    private

    def link_to_action_nested_fields(action, *args, &block)
      options = args.extract_options!.symbolize_keys
      options[:class] = [options[:class], "#{action}-nested-fields"].compact.join(" ")
      args << (options.delete(:href) || 'javascript:void(0)')
      args << options
      @template.link_to(*args, &block)
    end

  end
end