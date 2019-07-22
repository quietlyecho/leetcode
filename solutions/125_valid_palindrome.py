#
# Question: https://leetcode.com/problems/valid-palindrome/
# 

# method 1
class Solution:
    def isPalindrome(self, s: str) -> bool:
        if s is None:
            return False
        
        if s == "":
            return True
        
        s_alnum = []
        for i in s:
            if i.isalnum():
                s_alnum.append(i.lower())
        
        start = 0
        end = len(s_alnum) - 1
        
        while start < end:
            if s_alnum[start] != s_alnum[end]:
                return False
            start += 1
            end -= 1
            
        return True

# method 2
class Solution:
    def isPalindrome(self, s: str) -> bool:
        if s is None:
            return False
        
        if s == "":
            return True
        
        start = 0
        end = len(s) - 1
        
        while start < end:
            while start < end and not s[start].isalnum():
                start += 1
            while start < end and not s[end].isalnum():
                end -= 1
            if start < end and s[start].lower() != s[end].lower():
                return False
            start += 1
            end -= 1
            
        return True
