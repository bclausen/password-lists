
# length (integer) Länges Passworts
# lower_cases (boolean) Sollen Kleinbuchstaben verwendet werden?
# caps (boolean) Sollen Großbuchstaben verwendet werden?
# numbers (boolean) Sollen Zahlen verwendet werden?
# special_characters (string) Welche Sonderzeichen sollen verwendet werden?

length = 6
caps = false
numbers = true
special_characters ="!$%&"


def generate_passwd(length, caps, numbers, special_characters)  
  chars = "abcdefghjkmnpqrstuvwxyz" + special_characters
  if caps then
  	chars = chars + "ABCDEFGHJKLMNOPQRSTUVWXYZ"
  end
  if numbers then
  	chars = chars + "123456789"
  end

  Array.new(length) { chars[rand(chars.length)].chr }.join  
end  

puts generate_passwd(length, caps, numbers, special_characters)
