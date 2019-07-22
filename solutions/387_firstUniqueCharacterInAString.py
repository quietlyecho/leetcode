import collections
import sys

class Solution(object):
    def firstUniqChar1(self, s):
        """
        :type s: str
        :rtype: int
        """
        if s == "":
            return -1
        else:
            s_list =[]
            for letter in s:
                s_list.append(letter)
                
            cnt = collections.Counter(s_list)  
            
            for index in range(0, len(s)):
                if cnt[s_list[index]] == 1:
                    return index
                else:
                    if index == len(s) - 1:
                        return -1
                    else:
                        continue
                    
    def firstUniqChar2(self, s):
        """
        :type s: str
        :rtype: int
        """
        if s == "":
            return -1
        else:
            cnt = {}
            for i in range(0, 26):
                cnt[i] = -1
            
            for i in range(0, len(s)):
                if cnt[ord(s[i])-ord('a')] == -1: # meet the letter first time
                    cnt[ord(s[i])-ord('a')] = i
                elif cnt[ord(s[i])-ord('a')] >= 0: # meet the letter second time
                    cnt[ord(s[i])-ord('a')] = -2
                elif cnt[ord(s[i])-ord('a')] == -2: # meet the letter third time or more
                    pass
                else:
                    pass
            
            lowest_index = sys.maxint
            for i in range(0, 26):
                if cnt[i] >= 0 and cnt[i] < lowest_index:
                    lowest_index = cnt[i]
                else:
                    continue
            
            if lowest_index == sys.maxint:
                return -1
            else:
                return lowest_index
                    
                    
                    
            