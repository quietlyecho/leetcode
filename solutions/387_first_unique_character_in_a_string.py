#
# Question: https://leetcode.com/problems/first-unique-character-in-a-string/
#

# method 1, 
# use hash table to count and traverse again to get 1st count of 1
class Solution:
    def firstUniqChar(self, s: str) -> int:
        if len(s) < 1:
            return -1
        
        s_list = list(s)
        d = {}
        
        for i in range(len(s_list)):
            if s_list[i] not in d:
                d[s_list[i]] = 1
            else:
                d[s_list[i]] += 1
            
        for j in range(len(s_list)):
            if d[s_list[j]] == 1:
                return j
        
        return -1
