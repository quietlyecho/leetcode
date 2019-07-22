#
# Question: https://leetcode.com/problems/add-digits/
# 
# This is the concept of digital root:
#   https://en.wikipedia.org/wiki/Digital_root
# 

class Solution:
    def addDigits(self, num: int) -> int:
        while num >= 10:
            temp = 0
            while num > 0:
                temp = temp + num % 10
                num = num // 10
            num = temp
        return num

# follow up question: O(1) method
# The formula of digital root is here: https://en.wikipedia.org/wiki/Digital_root#Congruence_formula
class Solution:
    def addDigits(self, num: int) -> int:
        if num == 0:
            return 0
        else:
            return 1 + (num - 1) % 9
