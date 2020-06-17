class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # the !value.attached? is to handle the fact that the association might be optional. It would be nice to have this 
    # in some sort of options
    unless !value.attached? || value.content_type.in?(content_types)
      value.purge if record.new_record? # Only purge the offending blob if the record is new
      record.errors.add(attribute, :content_type, options)
    end
  end

  private

  def content_types
    options.fetch(:in)
  end
end