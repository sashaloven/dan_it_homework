# Determine class
class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = letters

    # print Alphabet
    def print(self):
        print("Alphabet:", self.letters)

    # return the number of letters
    def letters_num(self):
        return len(self.letters)


class EngAlphabet(Alphabet):
    # Static attribute to store n of en alp
    _letters_num = 26

    def __init__(self):
        # Initialize English alphabet letters
        super().__init__("En", "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    # check if a letter belongs to the English alphabet
    def is_en_letter(self, letter):
        return letter.upper() in self.letters

    # Override the letters_num method to return the number of English letters
    def letters_num(self):
        return EngAlphabet._letters_num

    # Static method text
    @staticmethod
    def example():
        return "Example of English text"



if __name__ == "__main__":
    
    eng_alphabet = EngAlphabet()

    eng_alphabet.print()
    print("Number of letters in English alphabet:", eng_alphabet.letters_num())
    print("Is 'F' in the English alphabet?", eng_alphabet.is_en_letter('F'))
    print("Is 'Щ' in the English alphabet?", eng_alphabet.is_en_letter('Щ'))
    print("Example text in English:", EngAlphabet.example())
