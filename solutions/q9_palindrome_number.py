# Question: https://leetcode.com/problems/palindrome-number/

class Solution_1:
    def isPalindrome(self, x: int) -> bool:
        if x < 0:
            return False
        elif x < 10:
            return True
        else:
            x_str = list(str(x))
            len_x_str = len(x_str)
            half_len = len_x_str // 2

            for i_l in range(half_len):
                i_r = len_x_str - 1 - i_l
                if x_str[i_l] != x_str[i_r]:
                    return False

            return True
