import collections

class Solution(object):
    def isAnagram(self, s, t):
        """
        :type s: str
        :type t: str
        :rtype: bool
        """
        # use counter
        cnt_s = collections.Counter(s)
        cnt_t = collections.Counter(t)
        return cnt_s == cnt_t
        
        # use sort
        l1=[]
        l2=[]
        for letter in s:
            l1.append(letter)
        for letter in t:
            l2.append(letter)
        l1.sort()
        l2.sort()
        return(l1==l2)
        
        