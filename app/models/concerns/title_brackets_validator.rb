class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if contains_empty_brackets?(record.title)
      record.errors.add :title, 'Title contains empty brackets'
    elsif incorrect_brackets?(record.title)
      record.errors.add :title, 'Title contains empty brackets'
    end
  end

private

  #checks if there are empty brackets (including brackets with only spaces)
  def contains_empty_brackets?(str)
    %w( {} () [] ).any? { |x| str.gsub(" ","").include? x }
  end

  #Checks for incorrect brackets
  def incorrect_brackets?(str)
    # get only brackets string
    str.gsub!(/[^(){}\[\]]/, "")

    # get rid of correct brackets until stack is nil or return true otherwise
    while str.length > 0 do
      if %w( {} () [] ).any? { |x| str.include? (x)}
        str.gsub!("()","")
        str.gsub!("{}","")
        str.gsub!("[]","")
      else
        return true
      end
    end

    # returns false if no incorrect brackets has been found
    return false
  end

end
