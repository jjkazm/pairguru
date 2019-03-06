class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if contains_empty_brackets(record.title)
     record.errors.add :title, 'Title contains empty brackets'
   end
  end

private

  #checks if there are empty brackets (including brackets with only spaces)
  def contains_empty_brackets(str)
    %w( {} () [] ).any? { |x| str.gsub(" ","").include? x }
  end

end
