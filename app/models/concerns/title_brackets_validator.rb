class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if contains_empty_brackets?(record.title)
      record.errors.add :title, ' contains empty brackets'
    elsif incorrect_brackets?(record.title)
      record.errors.add :title,
      ' contains incorrectly opened or closed brackets'
    end
  end

private

  #Returns true if title contains empty brackets (incl. brackets with spaces)
  def contains_empty_brackets?(str)
    %w( {} () [] ).any? { |x| str.gsub(" ","").include? x }
  end

  #Returns true if string contains not opened or not closed brackets
  def incorrect_brackets?(str)
    # get only brackets string
    brackets = str.gsub(/[^(){}\[\]]/, "")

    # get rid of correct brackets until brackets string is empty
    while brackets.length > 0 do
      if %w( {} () [] ).any? { |x| brackets.include? (x)}
        brackets.gsub!("()","")
        brackets.gsub!("{}","")
        brackets.gsub!("[]","")
      else
        return true
      end
    end

    # returns false if no incorrect brackets has been found
    return false
  end

end
