# Source: https://leetcode.com/problems/intersection-of-two-arrays-ii/description/

'''
Given two arrays, write a function to compute their intersection.

Example:
Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2, 2].

Note:
Each element in the result should appear as many times as it shows in both arrays.
The result can be in any order.

Follow up:
What if the given array is already sorted? How would you optimize your algorithm?
What if nums1's size is small compared to nums2's size? Which algorithm is better?
What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?
'''
import collections

class Solution(object):
    def intersect(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        cnt_1 = collections.Counter(nums1)
        cnt_2 = collections.Counter(nums2)
        inter_nums = []
        
        for k1 in cnt_1.iterkeys():
            if cnt_2[ k1 ] != 0:
               times = min( cnt_1[k1], cnt_2[k1] )
               inter_nums = inter_nums + [k1] * times
            
        return inter_nums