class Solution_1:
    def romanToInt(self, s: str) -> int:
        # Map symbol to values
        mapping = {
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000,
        }

        # Check subtraction patterns
        subtract_pat = {"IV": 4,
                        "IX": 9,
                        "XL": 40,
                        "XC": 90,
                        "CD": 400,
                        "CM": 900}
        letter_pairs = {"I": ("V", "X"), "X": ("L", "C"), "C": ("D", "M")}

        lst = list(s)
        len_lst = len(lst)
        num = 0
        i = 0

        while i <= len_lst - 1:
            letter = lst[i]
            if letter in letter_pairs.keys():
                if i < len(lst) - 1:
                    if lst[i+1] in letter_pairs[letter]:
                        letter_pair = f"{letter}{lst[i+1]}"
                        num += subtract_pat[letter_pair]
                        i += 2
                    else:
                        num += mapping[letter]
                        i += 1
                else:
                    num += mapping[letter]
                    i += 1
            else:
                num += mapping[letter]
                i += 1

        return num
