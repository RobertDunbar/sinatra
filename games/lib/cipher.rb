def caesar_cipher (phrase, shift)
    return "" if phrase.nil?
    shift %= 26
    cipher_str = ""
    phrase.each_byte do |char|
        case char
        when 65..90
            char + shift > 90 ? adj_char = 65 - (90 - char + 1) : adj_char = char
            cipher_str << (adj_char + shift).chr
        when 97..122
            char + shift > 122 ? adj_char = 97 - (122 - char + 1) : adj_char = char
            cipher_str << (adj_char + shift).chr
        else
            cipher_str << char.chr
        end
    end
    cipher_str
end